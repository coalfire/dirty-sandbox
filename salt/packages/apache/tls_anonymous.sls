anonymous_tls:
  file.managed:
    - source: salt://packages/apache/files/apache.config
    - name: /root/apache.config
    - require:
      - pkg: apache
    - watch_in:
      - service: apache
