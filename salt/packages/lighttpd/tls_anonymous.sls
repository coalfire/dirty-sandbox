anonymous_tls:
  file.managed:
    - source: salt://packages/apache/files/apache.config
    - name: /root/apache.config
    - require:
      - pkg: apache
    - watch_in:
      - service: apache

https:
  file.managed:
    - source: salt://packages/apache/files/https.conf
    - name: /etc/httpd/conf.d/https.conf
    - require:
      - pkg: apache
    - watch_in:
      - service: apache
