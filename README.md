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
  - name: Add fluent-plugin-mongo by this module
    win_fluent-gem:
    name: {{ items }}
    state: present
    with_itmes:
      - fluent-plugin-forest
      - fluent-plugin-mongo
      - fluent-plugin-azure-loganalytics
```
### with proxy
```
  tasks:
    - name: Install fluent plugin by win_fluent-gem module
      environment:
        http_proxy: http://10.10.10.1:8888
        https_proxy: http://10.10.10.1:8888
      win_fluent-gem:
        name: {{ items }}
        state: present
      with_itmes:
        - fluent-plugin-mongo
        - fluent-plugin-azure-loganalytics

```
