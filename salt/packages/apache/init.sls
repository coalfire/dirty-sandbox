apache:
  pkg.installed:
    - name: httpd
  group.present:
    - name: apache
    - system: True
  user.present:
    - name: apache
    - gid: apache
    - system: True
  service.running:
    - name: httpd
    - enable: True
