vsftpd-service:
  service:
    - running
    - enable: True
    - name: vsftpd
    - require: 
      - pkg: vsftpd-package

vsftpd-package:
  pkg.installed:
    - name: vsftpd
