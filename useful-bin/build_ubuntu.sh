#!/bin/bash

cp /boot/config-`uname –r`.config


scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --enable DEBUG_INFO_NONE
scripts/config --disable DEBUG_INFO

yes | make olddefconfig

make -j `getconf _NPROCESSORS_ONLN` bindeb-pkg LOCALVERSION=-custom
