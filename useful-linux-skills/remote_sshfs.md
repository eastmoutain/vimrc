

# install sshfs

# mount

```sh
$ sudo sshfs -o allow_other,default_permissions,follow_symlinks dsh@192.168.1.100:/remote_dir/to/mount  /local/mount/dir
```

# umount
```sh
sudo umount /local/mount/dir
```
