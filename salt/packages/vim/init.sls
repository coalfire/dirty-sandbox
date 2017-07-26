{% set vim = salt['grains.filter_by']({
  'RedHat': { 'package': 'vim-enhanced' },
  'Debian': { 'package': 'vim' },
}) %}

vim-package:
  pkg:
    - installed
    - name: {{ vim.package }}

/root/.vimrc:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    - source:
      - salt://packages/vim/vimrc

/root/.vim/bundle:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
        - user
        - group
        - mode

/root/.vim/autoload:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
        - user
        - group
        - mode

# curl -LSs https://tpo.pe/pathogen.vim >pathogen.vim
/root/.vim/autoload/pathogen.vim:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - source:
      - salt://packages/vim/pathogen.vim

# badwolf is managed elsewhere; makefile to fetch?
/usr/share/vim/vimfiles/colors/badwolf.vim:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - source:
      - salt://packages/vim/badwolf.vim
