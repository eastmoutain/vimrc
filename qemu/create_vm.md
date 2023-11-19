# boot linux

# boot linux kernel with qemu
## Create ramfs
```sh
$ mkinitramfs -o ramdisk.img
```

```sh
$ qemu-system-x86_64 -kernel arch/x86_64/boot/bzImage \
                    -nographic  -append "console=ttyS0 nokaslr" \
                    -initrd ramdisk.img \
                    -m 512
```
with numa nodes
```sh
$ qemu-system-x86_64 -kernel arch/x86_64/boot/bzImage \
                    -nographic  -append "console=ttyS0 nokaslr" \
                    -initrd ramdisk.img \
                    -smp cpus=4 -m 50G \
                    -object memory-backend-ram,size=25G,id=m0 \
                    -object memory-backend-ram,size=25G,id=m1 \
                    -numa node,memdev=m0,cpus=0-1,nodeid=0 \
                    -numa node,memdev=m1,cpus=2-3,nodeid=1
                    -chardev pty,id=charserial0 -device isa-serial,chardev=charserial0,id=serial0


```

# Create boot disk


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

## boot with server image, the image is qcow format
1. download image from https://cloud-images.ubuntu.com/

2. change password 
    install tlibguestfs-tools
    #sudo apt-get install libguestfs-tools
    #sudo virt-customize -a focal-server-cloudimg-amd64.img --root-password password:root

3. increase image size
    qemu-img resize focal-server-cloudimg-amd64.img +10G
    boot the vm
    # growpart /dev/sda [m]
    # resize2fs /dev/sda[m]

    ```sh
    $ sudo ssh-keygen -A 
    $ sudo vi /etc/ssh/sshd_config
       # chanage `PasswordAuthentication yes` 
     $ sudo vi /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
	# chanage `PasswordAuthentication yes`
    $ sudo service ssh restart
    ```

## redirect serial port to /dev/pts device

```sh
-chardev pty,id=charserial0 -device isa-serial,chardev=charserial0,id=serial0
```

open minicom to see the log from qmeu

## share host foler with qemu guest
   1. build qemu with virtfs enabled, adding the following line to qemu configure.sh args
      ```sh
      --enable-virtfs
      ```
   2. boot qemu with cmd args
      ```sh
      -virtfs local,path=/path/to/share,mount_tag=host0,security_model=passthrough,id=host0 \
      ```
   3. mount the shared folder in guest
      edit guest /etc/fstab, add lines:
      ```sh
      host0  /home/thomas/hostshare  9p trans=virtio,version9p2000.L 0 0
      ```
