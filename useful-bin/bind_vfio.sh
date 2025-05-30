#!/bin/bash

# insmode vfio driver first
sudo modprobe vfio_virqfd
sudo modprobe vfio_pci
sudo modprobe vfio_iommu_type1
sudo modprobe vfio


# 1. unbind device to its original driver
echo "0000:01:00.0" > /sys/bus/pci/devices/0000\:01\:00.0/driver/unbind

# 2. bind device to vfio-pci driver
echo "0000:01:00.0" > /sys/bus/pci/drivers/vfio-pci/bind

# or bind the deive to vfio newid
echo "vid did" > /sys/bus/pci/drivers/vfio-pci/new_id

