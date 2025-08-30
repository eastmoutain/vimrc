# how to install driver
Download nvidia tookit from https://developer.nvidia.com/cuda-toolkit.
Select the run package, grant executable permission to the run file. It will
install nvidia driver and cuda toolkit.

After successful installation, it prints the following log:
```sh
Driver:   Installed
Toolkit:  Installed in /usr/local/cuda-13.0/

Please make sure that
 -   PATH includes /usr/local/cuda-13.0/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-13.0/lib64, or, add /usr/local/cuda-13.0/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-13.0/bin
To uninstall the NVIDIA Driver, run nvidia-uninstall
Logfile is /var/log/cuda-installer.log
```
# how to uninstall driver and cuda toolkit

```
/usr/local/cuda-13.0/bin/cuda-uninstaller

nvidia-uninstall
```

