base:
  'role:salt_master':
    - match: grain
    - packages.salt-master
    - packages.tmux
    - packages.vim


  'role:unknown_service':
    - match: grain
    - packages.tmux
    - packages.vim

  'role:anonymous_key':
    - match: grain
    - packages.lighttpd
    - packages.tmux

  'role:insecure_services':
    - match: grain
    - packages.tmux
    - packages.vim
    - packages.vsftpd
