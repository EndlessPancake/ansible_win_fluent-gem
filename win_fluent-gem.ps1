#!powershell

# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
# Copyright: (c) 2018, endless pancake <endless.pancake4u@gmail.com>

#Requires -Module Ansible.ModuleUtils.Legacy
#Requires -Module Ansible.ModuleUtils.SID

$ErrorActionPreference = "Stop"

$params = Parse-Args -arguments $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -default $false
$diff_mode = Get-AnsibleParam -obj $params -name "_ansible_diff" -type "bool" -default $false

# Parameters
$name = Get-AnsibleParam -obj $params -name "name" -failifempty $true
$gem_source = Get-AnsibleParam -obj $params -name "gem_source"
$state = Get-AnsibleParam -obj $params -name "state" -default "present"
$version = Get-AnsibleParam -obj $params -name "version"

$result @{
  before_value = $before_value
  changed = $false
  value = $value
}

if ($diff_mode) {
    $result.diff = @{}
}

# td-agent Installed ?
function Find_fluent-gem {
    [CmdletBinding()]
    param()
    $p = Find-Command "fluent-gem"
    if ($p -ne $null){
        return $p
    }
    $a = Find-Command "C:\opt\td-agent\embedded\bin\fluent-gem"
    if ($a -ne $null){
        return $a
    }
    Fail-Json -obj $result -message "td-agent/fluent-gem is not installed, yet."
}

# Install remote plugins
function Install_FluentGems {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)]
    [string]$name,
    [string]$version,
    [bool]$check_mode
  )
  if ($version -ne $null){
    set PATH="%~dp0embedded\bin";%PATH%
    fluent-gem install $name $version
  }
 else {
    set PATH="%~dp0embedded\bin";%PATH%
    fluent-gem install $name
  }
}
# Install from local
function Install_local_FluentGems {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)]
    [string]$gem_source,
    [bool]$check_mode
  )
  if ($gem_source -ne $null){
    set PATH="%~dp0embedded\bin";%PATH%
    fluent-gem install --local $gem_source
  }
}
# Remove plugins
function Uninstall_FluentGems {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)]
    [string]$name,
    [string]$version,
    [bool]$check_mode
  )
  if ($version -ne $null){
    set PATH="%~dp0embedded\bin";%PATH%
    fluent-gem uninstall $name $version
  }
  else {
    set PATH="%~dp0embedded\bin";%PATH%
    fluent-gem uninstall $name
  }
}

## main
if ($state -eq "present"){
  # remote plugins
  Install_FluentGems
}
else {
  Uninstall_FluentGems
}

if ($gem_source -ne $null ){
  Install_local_FluentGems
}

Exit-Json -obj $result
