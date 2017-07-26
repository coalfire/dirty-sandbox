salt-master-service:
  service:
    - running
    - enable: True
    - name: salt-master
    - watch: 
      - file: salt-key-accept
      - file: salt-gitfs

salt-master-dir:
  file.directory:
    - name: /etc/salt/master.d
    - user: root
    - group: root
    - dir_mode: 700
    - file_mode: 600
    - recurse:
      - user
      - group 
      - mode

salt-key-accept:
  file:
    - managed
    - name: /etc/salt/master.d/auto_accept.conf
    - source: salt://packages/salt-master/master.d/auto_accept.conf
    - require:
      - file: salt-master-dir

salt-gitfs:
  file:
    - managed
    - name: /etc/salt/master.d/gitfs.conf
    - source: salt://packages/salt-master/master.d/gitfs.conf
    - require:
      - file: salt-master-dir

