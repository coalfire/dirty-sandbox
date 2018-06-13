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

lighttpd-docroot:
  file.directory:
    - name: /var/www/htdocs
    - user: lighttpd
    - group: lighttpd
    - mode: 0755
    - require: 
      - pkg: lighttpd-package

lighttpd-cert-dir:
  file.directory:
    - name: /etc/lighttpd/certs
    - user: root
    - group: root
    - mode: 0755
    - require: 
      - pkg: lighttpd-package

lighttpd-cert:
  cmd.run:
    - creates: /etc/lighttpd/certs/lighttpd.pem
    - name: cd /etc/lighttpd/certs; openssl req -new -x509 -keyout lighttpd.pem -out lighttpd.pem -days 365 -nodes; chmod 600 lighttpd.pem
