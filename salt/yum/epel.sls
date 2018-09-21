epel-package:
  pkg:
    - installed
    - name: epel-release
    - require_in:
      pkg:
        lighttpd-package
