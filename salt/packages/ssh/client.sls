{% from "packages/ssh/map.jinja" import ssh with context %}
/etc/ssh/ssh_config:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source:
      - salt://packages/ssh/files/ssh_config.LH
    - require:
      - pkg: {{ ssh.client }}

sshclient-package:
  pkg:
    - installed
    - name: {{ ssh.client }}
