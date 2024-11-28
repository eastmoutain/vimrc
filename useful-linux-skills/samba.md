# setup samba server on ubuntu

Install samba on server
```sh
sudo apt update
sudo apt install samba
mkdir ~/sambashare/
```

Add the following to /etc/samba/smb.conf
```sh
[sambashare]
    comment = Samba on Ubuntu
    path = /home/username/sambashare
    read only = no
    browsable = yes
``

Start samba service
```sh
sudo service smbd restart
````

Update the firewall rules to allow Samba traffic:
```sh
sudo ufw allow samba
```


# mount samba on ubuntu client

Install cifs-utils on client
```sh
sudo apt-get install cifs-utils
sudo mkdir /mnt/smb_share
```

Edit /etc/fstab, add the following content.
Replace username and password accrodingly.

```sh
//192.168.X.X/sambashare /mnt/smb_share cifs username=USERNAME,password=PASSWORD,iocharset=utf8
```

In terminal, mount samba share folder. 
```
sudo mount /mnt/smb_share
```



