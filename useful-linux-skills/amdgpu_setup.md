# amdgpu passthrough

## Environment configuration
* hardware: Radeon RX 5600

	RX5600 is coupled with audio card

	```sh
	2f:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 [Radeon RX 5600 OEM/5600 XT / 5700/5700 XT] (rev c4)
	2f:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 HDMI Audio
	```

* software

	Host: ubuntu 20.04

## host cmdline

edit /etc/default/grub, add "amd_iommu=on iommu=pt" to command line

```sh
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amd_iommu=on iommu=pt"
```

## bind amdgpu to vfio

edit /etc/modprobe.d/vfio.conf, bind amdgpu (1002:731f) and video (1002:ab38) to vfio.

to prevent video driver is loaded before vfio module,  add softdep to load vfio before video module.

```sh
options vfio-pci ids=1002:731f,1002:ab38
softdep drm pre: vfio-pci
```



# passthrough amdgpu to VM with qemu

```sh
#!/bin/bash

echo 1 | sudo tee  /sys/module/vfio_iommu_type1/parameters/allow_unsafe_interrupts

qemu-system-x86_64 \
        -enable-kvm -m 8G -cpu host -smp 16 -nographic \
        -drive file=focal-server-cloudimg-amd64-2004.img \
        -bios ./OVMF_CODE.fd \
        -device vfio-pci,host=2f:00.0 \
        -device vfio-pci,host=2f:00.1 \
        -net nic -net user,hostfwd=tcp::2222-:22
```



# install firmware

download amdgpu firmware from
```
https://ftp.debian.org/debian/pool/non-free-firmware/f/firmware-nonfree/
```

and, install it

or try command:
```sh
$ sudo apt install amdgpu-dkms-firmware
```

# install rocm 

reference: https://docs.amd.com/en/latest/deploy/linux/quick_start.html

## 1. Download and convert the package signing key

## 2. Add the repositories

## 3. Update the list of packages

```sh
$ sudo apt install rocm-hip-libraries
```

## follow the guide, then install rocm-hip-sdk


# test

## run kfdtest
* Down load ROCT-Thunk-Interface
  ```sh
  $ git clone https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface
  ```
* build kfdtest
  You should install rocm in advance, refer to section "install rocm".
  To build kfdtest, export LLVM_DIR
  ```sh
  $ exprot LLVM_DIR=/opt/rocm-5.7.0/llvm/lib/cmake
  $ cd tests/kfdtest
  $ mkdir build
  $ cd build
  $ cmake ..
  $ make
  $ sudo make install
  
  $ cd ../scripts
  $ ./run_kfdtest.sh
  ```
