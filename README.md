# ansible_win_fluent-gem

Work in progress

## Installation:
Copy ***win_fluent-gem.ps1*** and ***win_fluent-gem.py*** files to **[default-module-path](http://docs.ansible.com/ansible/latest/reference_appendices/config.html#default-module-path)** directory

## How to use this
```
---
- name: Install fluent plugins by td-agent's fluent-gem
  hosts: your Windows Server
  tasks:
  - name: Add fluent-plugin-mongo
    win_fluent-gem:
      record: host01
      state: present
```
