
## set grub timeout
```sh
GRUB_TIMEOUT=5
```

## set earlyprintk
```sh
earlyprintk=serial,ttyS0,115200
```

## set console
```sh
console=ttyS0 console=tty1
```

## disable submenu option to display all kernels
```sh
GRUB_DISABLE_SUBMENU=y
```

## set default kernel option
Check available kernel options
```sh
sudo grep 'menuentry' /boot/
```

There maybe warning, just ignore it.

```sh
GRUB_DEFAULT='Ubuntu, with Linux 5.10.112-zp-sev-es-siv'
```

## set console out

append to kernel option
```sh
GRUB_TERMINAL=console
```
```sh
console=ttyS0
```

## Update grub

### Ubuntu
```sh
sudo update-grub
```

### Centos
```sh
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```
or 
```sh
sudo grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg
```
# Set default kernel

## Ubuntu and Centos
Edit /etc/default/grub, set
```sh
GRUB_DEFAULT='Ubuntu, with Linux 5.10.112-zp-sev-es-siv'
```
## Anolis
* Check default kernel
```sh
sudo grubby --default-kernel
```

* List all kernels
```sh
sudo grubby --info=ALL | grep ^kernel

kernel="/boot/vmlinuz-5.10.112-zp-sev-es-siv"
kernel="/boot/vmlinuz-6.6.88-csv"
```

* set default kernel
```sh
sudo grubby --set-default=/boot/vmlinuz-6.6.88-csv
```
