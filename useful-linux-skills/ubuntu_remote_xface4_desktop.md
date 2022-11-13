
# How to use remote desktop on ubuntu

```sh
sudo apt install xfce4 xfce4-goodies -y
sudo apt install xrdp -y

echo "xfce4-session" | tee ~/.xsession

sudo systemctl restart xrdp

reboot 

```

