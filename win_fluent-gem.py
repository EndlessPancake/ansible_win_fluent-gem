#!/usr/bin/python
# -*- coding: utf-8 -*-

# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
# endless pancake <endless.pancake4u@gmail.com>

ANSIBLE_METADATA = {'metadata_version': '1.0',
                    'status': ['preview'],
                    'supported_by': 'individual'}

DOCUMENTATION = r'''
---
module: win_fluent-gem
version_added: "2.7"
short_description: Install fluent plugins.
description:
    - Install fluent plugins by td-agent's fluet-gem.
notes:
    - Attention, This is NOT for General Ruby gem's module.
    - Td-agent for Windows need to be installed
    - Tested on Latest td-agent3
options:
  name:
    description:
      - name of plugins
    required: true
  gem_source:
    description:
      - destination folder
    required: false
  state:
    description:
      - The desired state of the gem. C(latest) ensures that the latest version is installed.
    required: false
    choices: [present, absent]
    default: present
  version:
    description:
      - Set specific Versions, if you needed.
    required: false
author:
- endless pancake
'''

EXAMPLES = r'''
  # Install plugins you want.
  win_fluent-gem:
    name: {{ items }}
    state: present
    with_itmes:
      - fluent-plugin-forest
      - fluent-plugin-mongo
      - fluent-plugin-azure-loganalytics
'''
