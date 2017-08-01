lighttpd-package:
  pkg:
    - installed
    - name: lighttpd

lighttpd-selinux:
  selinux.boolean:
    - name: httpd_setrlimit
    - value: True
    - persist: True

lighttpd-service:
  service:
    - name: lighttpd
    - running 
    - require: 
      - pkg: lighttpd-package
    - enable: True
    - watch:
      - file: lighttpd-config

lighttpd-docroot:
  file.directory:
    - name: /var/www/htdocs
    - user: lighttpd
    - group: lighttpd
    - mode: 0755
    - require: 
      - pkg: lighttpd-package


lighttpd-config:
  file.managed:
    - source: salt://packages/lighttpd/files/lighttpd.conf
    - name: /etc/lighttpd/lighttpd.conf
    - user: root
    - group: root
    - mode: 644
    - require: 
      - pkg: lighttpd-package
