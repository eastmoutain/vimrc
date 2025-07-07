#!/bin/bash

export KBUILD_OUTPUT=output

mkdir -p output

verion=`uname -r`
echo "cp /boot/config-$verion output/.config"
cp /boot/config-$verion output/.config

scripts/config --file output/.config --disable SYSTEM_TRUSTED_KEYS
scripts/config --file output/.config --disable SYSTEM_REVOCATION_KEYS
scripts/config  --file output/.config --disable DEBUG_INFO_DWARF5
scripts/config --file output/.config --enable DEBUG_INFO_NONE
scripts/config --file output/.config --disable DEBUG_INFO
scripts/config --file output/.config --disable CONFIG_DEBUG_INFO_BTF
scripts/config --file output/.config --disable CONFIG_DEBUG_INFO
scripts/config --file output/.config --disable CONFIG_DEBUG_INFO_DWARF4

make O=output olddefconfig

make -j `getconf _NPROCESSORS_ONLN` bindeb-pkg LOCALVERSION=-custom -f Makefile
