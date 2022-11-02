# boot linux

## create hard disk image

For example, create a disk, the size is 50G

```sh
qemu-img create -f qcow2 disk.qcow2 50G
```

## install ISO to hard disk

``` sh
qemu-system-x86_64 -enable-kvm -m 2048 -smp 4 \
                    -cdrom ubuntu-22.04-desktop-amd64.iso \
                    -drive file=disk.qcow2
```
The command will install the ISO to hard disk. Once installation is finished,
you can remove `cdrom` argument from the command line.

## other useful qmeu args

* -enable-kvm
* -net nic -net user,hostfwd=tcp::2222-:22
    The arg adds an virtul network to the system, user can access vm from host prot TCP
    port 2222 to vm port 22
* -vga virtio
    enlarge the resolution of qemu GUI


