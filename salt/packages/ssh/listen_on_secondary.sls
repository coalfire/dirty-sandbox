include:
  - .

/etc/ssh/sshd_config:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source:
      - salt://packages/ssh/files/listen_on_secondary
    - require_in:
      - service: ssh
    - watch_in:
      - service: ssh
