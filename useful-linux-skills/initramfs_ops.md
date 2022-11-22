
The tutorial shows how to create an initramfs from dir,
and the reverse operations.

# create an initramfs from a directory
```sh
$ cd dir
$ find . | cpio -H newc -o | gzip -9 > initramfs
```

# restore initramfs to dir
```sh
$ cd dir
$ gunzip -c initramfs | cpio -i
```

# Modify an initramfs
 - there are two ways, 1st is as the above, restore initramfs into
   a dir, and then edit it
 - the 2'nd way is uncompressing it and mount to a dir, then do edit,
   and finialy unmount it.
   ```sh
   $ mkdir temp_dir
   $ gunzip -c initramfs > initramfs.img
   $ mount -t ext2 -o loop initramfs.img temp_dir
   # edit file
   $ umount temp_dir
   ```
