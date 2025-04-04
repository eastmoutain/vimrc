
# How to use remote desktop on ubuntu

```sh
$ sudo apt install xfce4 xfce4-goodies -y
$ sudo apt install xrdp -y
$ 
$ echo "xfce4-session" | tee ~/.xsession
$ 
$ sudo systemctl restart xrdp
$
$ xhost +local:
$ 
$ reboot 
```

# If you should use sudo cmd, you should also:

```sh
$ su root
$ echo xfce4-session >~/.xsession
$ su -
```

else, you will receive error message:

    "Authorization required, but no authorization protocol specified"

# Reference
1. https://www.digitalocean.com/community/tutorials/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04
