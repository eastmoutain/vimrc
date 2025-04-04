
## How to integrate initramfs into bzImage

1. set INITRAMFS_SOURCE points to initramfs image.
    for example:
    ```./scripts/config --set-str INITRAMFS_SOURCE "./initramfs_soruce/rootfs.cpio.gz" ```
2. rebuild bzImage
3. don't set initrd paramter in qemu command line or kernel grub config file

