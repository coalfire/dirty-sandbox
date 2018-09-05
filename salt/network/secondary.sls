eth1:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - name: eth1
    - ipaddr: 172.30.1.8
    - netmask: 255.255.255.0

eth1-routes:
  file.managed:
    - name: /etc/sysconfig/network-scripts/route-eth1
    - owner: root
    - group: root
    - mode: 644
    - source: salt://network/files/route-eth1

eth1-rules:
  file.managed:
    - name: /etc/sysconfig/network-scripts/rule-eth1
    - owner: root
    - group: root
    - mode: 644
    - source: salt://network/files/rule-eth1

rt_tables:
  file.managed:
    - name: /etc/iproute2/rt_tables
    - owner: root
    - group: root
    - mode: 644
    - source: salt://network/files/rt_tables
