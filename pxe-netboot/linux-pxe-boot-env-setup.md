# setup linux pxe boot env

## download boot files

* ubuntu legancy: http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/
* Ubuntu UEFI: http://archive.ubuntu.com/ubuntu/dists/focal/main/uefi/grub2-amd64/current/

### DPCP server

* install

	on ubnntu:

	```sh
	$ sudo apt install isc-dhcp-server
	```

	on centos:

	```sh
	$ sudo dnf install dhcp
	```

	

* /etc/default/isc-dhcp-server

	```sh
	INTERFACESv4="enp5s0"
	INTERFACESv6="enp5s0"
	INTERFACES="enp5s0"
	```

	add these lines to specifiy the interface that DHCP should cover.

	You should moditfy the network interface name to yours accordingly.

	refer to https://netstudy.zlabs.be/22-install-dhcp-server/ for more platform such as centos

* config DHCP server

	Ubuntu: edit /etc/dhcp/dhcpd.conf

	```sh
	# /etc/dhcp/dhcpd.conf
	
	option domain-name "example.org";
	option domain-name-servers ns1.example.org, ns2.example.org;
	
	default-lease-time 600;
	max-lease-time 7200;
	
	ddns-update-style none;

    set vendorclass = option vendor-class-identifier;
	set pxetype = option pxe-system-type;
	
	subnet 10.1.1.0 netmask 255.255.255.0 {
	    range 10.1.1.3 10.1.1.154;
	    option domain-name-servers 10.1.1.1, 8.8.8.8;
	    option routers 10.1.1.1;
	
	    filename "bootx64.efi";
	
	    if substring(vendorclass, 0, 9)="PXEClient" {
	        if pxetype=00:06 or pxetype=00:07 {
	        		# tell bootloader file, bootx64.efi for UEFI mode
	            filename "bootx64.efi";
	        } else {
	        	# pxelinux.0 for Legancy mode
	            filename "pxelinux.0";
	        }
	    }
	
	    # tell tftp server ipaddress
	    next-server 10.1.1.1;
	}
	```

	then restart dhcp server and check the status

	```sh
	$ sudo systemctl restart isc-dhcp-server
	$ sudo systemctl status isc-dhcp-server
	```

	

### TFTP Server

* install TFTP server

	```sh
	$ sudo apt install tftpd-hpa
	```

	

* restart TFTP server

	```sh
	$ sudo systemctl restart tftpd-hpa.service
	```

* check TFTP status

	```sh
	$ sudo systemctl status tftpd-hpa.service
	```

	

* config TFTP server

	Creat a dir in /srv/tftpboot, and chown of the dir with cmd:

	 ```sh
	$ sudo chown tftp:tftp /srv/tftpboot
	 ```

	

	edit  **/etc/default/tftpd-hpa**

	```sh
	TFTP_USERNAME="tftp"
	TFTP_DIRECTORY="/srv/tftpboot"
	TFTP_ADDRESS=":69"
	TFTP_OPTIONS="--secure --create"
	```

	Each time after modifing the config file, you should restart the service

	```sh
	$ sudo systemctl restart tftpd-hpa.service
	```

* verify tftp server

	you should install **tftp-hpa** client tool

	```sh
	$ sudo apt install tftp-hpa
	```

	then you can put or get file from tftp server's root dir, for example, upload file a.txt to tftp server root dir from client, that's /srv/tftpboot in our case.

	```sh
	// client
	$ tftp TFTP_SERVER_IP_ADDRESS
	put a.txt
	```

	Note: replace TFTP_SERVER_IP_ADDRESS to your tftp server IP address.

	You will find a.txt is at your tftp server's /srv/tftpboot dir now.

	If you have login tftp server, you can user **localhost** or **127.0.0.1** as tftp server IP address

* Add files to tftpboot dir

	Here is the contents of **tftpboot** dir

	```sh
	/srv/tftpboot
	├── bootx64.efi
	├── bzImage
	├── grub
	│   ├── fonts
	│   └── grub.cfg
	├── grubx64.efi
	└── initramfs.img
	```

	the contents of grub.cfg

	```sh
	# grub.cfg
	set default="0"
	set timeout=3
	
	if loadfont unicode ; then
	  set gfxmode=auto
	  set locale_dir=$prefix/locale
	  set lang=en_US
	fi
	terminal_output gfxterm
	
	set menu_color_normal=white/black
	set menu_color_highlight=black/light-gray
	if background_color 44,0,30; then
	  clear
	fi
	
	function gfxmode {
	        set gfxpayload="${1}"
	        if [ "${1}" = "keep" ]; then
	                set vt_handoff=vt.handoff=7
	        else
	                set vt_handoff=
	        fi
	}
	
	set linux_gfx_mode=keep
	
	export linux_gfx_mode
	
	menuentry 'Ubuntu 20.04' {
	        gfxmode $linux_gfx_mode
	        echo 'Loading linux kernel'
	        #linux bzImage $vt_handoff quiet splash console=ttyS0,115200 console=tty0
	        linux bzImage $vt_handoff console=ttyS0,115200 console=tty1
	        echo 'Load initial ramdisk'
	        initrd initramfs.img
	    echo 'start booting...'
	    boot
	}
	```

	

### enable dhcp and tftp Ports



### Fix ^H character if press failed

```sh
$ stty erase ^H
```



### PXE config

* set IP address to interface, which should identical to DHCP config file

	```sh
	sudo if config enp5s0 10.1.1.1
	```

	
