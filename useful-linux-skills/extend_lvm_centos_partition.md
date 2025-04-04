# How to extend lvm partion to full disk

```sh
$ lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
fd0               2:0    1    4K  0 disk
sda               8:0    0   20G  0 disk
├─sda1            8:1    0  500M  0 part /boot
└─sda2            8:2    0  4.5G  0 part
  ├─centos-root 253:0    0    4G  0 lvm  /
  └─centos-swap 253:1    0  512M  0 lvm  [SWAP]
sr0              11:0    1 1024M  0 rom
```

# suloution:

There are three steps to make:
1. alter your partition table so sda2 ends at end of disk
2. reread the partition table (will require a reboot)
3. resize your LVM pv using pvresize


## alter partition table
* execute cmd : fdisk /dev/sda
                enter 'p', print partition table, save it somewhere
* delete partition: enter 'd' to remvoe sda2 in this example.
* create new partion: enter 'n'. notice the start and the end address shoud be the entire disk
* change partion type: enter 't', then '2', then '8e', this set the new partion type to Linux LVM
* review the new partion: 'p'
* save the partition: 'w'

## reboot the machine
* retboot

## resize the LVM PV
* pvresize /dev/sda2


