#!/bin/bash

export KBUILD_OUTPUT=output

mkdir -p output

verion=`uname -r`
echo "cp /boot/config-$verion output/.config"
cp /boot/config-$verion output/.config

scripts/config --file output/.config --disable SYSTEM_TRUSTED_KEYS
scripts/config --file output/.config --disable SYSTEM_REVOCATION_KEYS
scripts/config --file output/.config --enable DEBUG_INFO_NONE
scripts/config --file output/.config --disable DEBUG_INFO

yes | make olddefconfig

make -j `getconf _NPROCESSORS_ONLN` binrpm-pkg LOCALVERSION=-custom -f Makefile
