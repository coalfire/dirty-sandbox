{% from "packages/ssh/map.jinja" import ssh with context %}

ssh_server:
  pkg.installed:
    - name: {{ ssh.server }}

ssh:
  service.running:
    - name: {{ ssh.service }}
    - require:
      - pkg: {{ ssh.server }}
