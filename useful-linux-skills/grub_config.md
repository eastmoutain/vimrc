
## set grub timeout
```sh
GRUB_TIMEOUT=5
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
