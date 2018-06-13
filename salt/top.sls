base:
  '*':
    - packages.tmux
    - packages.vim

  'role:salt_master':
    - match: grain
    - packages.salt-master

  'role:unknown_service':
    - match: grain

  'role:anonymous_key':
    - match: grain
    - packages.lighttpd.basic

  'role:insecure_services':
    - match: grain
    - packages.vsftpd

  'role:multi_ip':
    - match: grain
    - packages.lighttpd.listen-on-secondary
