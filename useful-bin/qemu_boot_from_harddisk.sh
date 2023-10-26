#!/bin/bash

# Note:
#    1. ensuru the linux os on the disk has set "console=ttyS0"
#        in the cmdline. for example /etc/default/grub
#    2. If no output from the termninal, you'd better comment  '-nographic'
#       and boot it with GUI.
#    3. To install linux on the disk, uncommnet the last line

#/home/thomas/project/qemu/qemu_output/bin/qemu-system-x86_64 \
qemu-system-x86_64 \
    -enable-kvm -m 16G -cpu host -smp 10 -nographic \
    -bios OVMF.fd \
    -drive file=/dev/sdd,media=disk,format=raw \
    -net nic -net user,hostfwd=tcp::2222-:22

    #-cdrom ubuntu-22.04.3-live-server-amd64.iso

