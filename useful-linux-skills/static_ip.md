# how to set static IP addr for linux

* show network interface info
```sh
$ nmcli connection show
```

* Create a Static connection
    Note: replace enp0s3 with your network interface name, for example: eth0, and target IP address
```sh
$ sudo nmcli con add type ethernet con-name 'static-ip' ifname enp0s3 ipv4.method manual ipv4.addresses 192.168.1.102/24 gw4 192.168.1.1
```

* Add DNS IP to static-ip
```sh
$ sudo nmcli con mod static-ip ipv4.dns 192.168.1.1
```

* Activate the Static connection
```sh
$ sudo nmcli con up id 'static-ip'
```

* Verify the IP assignment to the selected device
```sh
$ ip a
``
# how to set static IP addr for OSX

* show network interface info
```sh
$ networksetup -listallnetworkservices
```

The output:
```sh
Hardware Port: Ethernet
Device: en0
Ethernet Address: d0:11:e5:32:84:ce

Hardware Port: Wi-Fi
Device: en1
Ethernet Address: d0:11:e5:33:ae:70
```
For example, the device is en0, the network service is "Ethernet" (the name of the network service)

* set static IP addr
```sh
$ sudo networksetup -setmanual "Ethernet" 192.168.1.103 255.255.255.0 192.168.1.1
$ sudo networksetup -setdnsservers "Ethernet" 8.8.8.8 1.1.1.1
```

* verify
```sh
$ networksetup -getinfo "Ethernet"
```
The output:
```sh
Manual Configuration
IP address: 192.168.1.103
Subnet mask: 255.255.255.0
Router: 192.168.1.1
IPv6: Automatic
IPv6 IP address: none
IPv6 Router: none
Ethernet Address: d0:11:e5:32:84:ce
```
