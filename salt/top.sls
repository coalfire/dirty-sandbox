base:
  'role:salt-master':
    - match: grain
    - packages.salt-master
    - packages.tmux
    - packages.vim


  'role:unknown-service':
    - match: grain
    - packages.tmux
    - packages.vim

  'role:anonymous-key-agreement':
    - match: grain
    - packages.tmux

  'role:insecure-services':
    - match: grain
    - packages.tmux
    - packages.vim
    - packages.vsftpd


