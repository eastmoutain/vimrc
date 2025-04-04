#!/bin/bash

mkdir -p build
cd build

    #--enable-system --enable-linux-user \
    #--enable-numa \
    #--disable-vnc --enable-sdl \
../configure --target-list=x86_64-softmmu \
    --sysconfdir=/etc/ \
    --audio-drv-list= \
    --disable-docs \
    --disable-curl \
    --enable-kvm \
    --enable-virtfs \
    --prefix=/home/thomas/project/qemu/qemu_output \
    && \
    make -j128 && make install

cd ..
