# how to set static IP addr

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
```
