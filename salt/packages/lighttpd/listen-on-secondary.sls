include:
  - .

lighttpd-config:
  file.managed:
    - source: salt://packages/lighttpd/files/listen-on-secondary.lighttpd.conf
    - name: /etc/lighttpd/lighttpd.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: lighttpd-package
    - watch_in:
      - service: lighttpd-service


