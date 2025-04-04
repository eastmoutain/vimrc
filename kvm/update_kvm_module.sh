#!/bin/bash

make
if [ $? -ne 0 ]; then
    echo "make failed"
    exit -1
fi

sudo rmmod kvm_amd
if [ $? -ne 0 ]; then
    echo "rmmod kvm_amd failed, ignore!"
fi

sudo rmmod kvm
if [ $? -ne 0 ]; then
    echo "rmmod kvm failed, ignore!"
fi

sudo insmod kvm.ko && \
if [ $? -ne 0 ]; then
    echo "insmod kvm.ko failed"
    exit -1
fi

sudo insmod kvm-amd.ko
if [ $? -ne 0 ]; then
    echo "insmod kvm-amd.ko failed"
    exit -1
fi
