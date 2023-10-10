#!/bin/bash

verion=`uname -r`
echo "cp /boot/config-$verion .config"
cp /boot/config-$verion .config

scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --enable DEBUG_INFO_NONE
scripts/config --disable DEBUG_INFO

yes | make olddefconfig

nproc=`getconf _NPROCESSORS_ONLN`
make -j $nproc bindeb-pkg LOCALVERSION=-custom
