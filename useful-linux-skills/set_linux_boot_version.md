# ubuntu

## get the kernel version
```sh
# grep linux-5.11 /boot/grub/grub.cfg
```
for example, it prints something like below;
'gnulinux-5.19.0-46-generic-advanced-1a212b3d-5136-4c01-9d89-8f47d0c6c859'

## set boot kernel version
```sh
# vim /etc/default/grub
# GRUB_DEFAULT='gnulinux-5.19.0-46-generic-advanced-1a212b3d-5136-4c01-9d89-8f47d0c6c859'
```
## udpate grub
```sh
# sudo update-grub
```

# centos
