# ubuntu

## build debin packages
    1. install necessary packages 
    ```sh
    $ sudo apt install sudo apt install build-essential bison flex gnupg libncurses-dev libelf-dev libssl-dev wget
    ```
    2. copy kernel .config
    ```sh
    $ cp cp /boot/config-$(uname -r) .config
    ```
    3. To preemptively accept the default answer to all those questions, run ...
    ```sh
    $ make olddefconfig
    ```
    4. make debin packages with custom version, new .deb packages are built and displaced at the top level dir
    ```sh
    $ make clean
    $ make deb-pkg LOCALVERSION=-custom
    ```
    5. install new kernel
    ```sh
    $ sudo dpkg -i *.deb
    ```
    6. reboot

## update default kernel version from grub
### Method 1:
    edit /etc/default/grub, add
    ```sh
    # it means that set the second menu (1) and then the third entry (2) of grub interface as the default kernel
    GRUB_DEFAULT to "1>2"
    ...
    ```

    then
    ```sh
    sudo update-grub
    ```

### Method 2:
    edit /etc/default/grub. add:
    ```sh
    GRUB_SAVEDEFAULT=true
    GRUB_DEFAULT=saved
    ```

    then
    ```sh
    sudo update-grub
    ```

    then reboot, select the kernel manually, grub will save the one you selected to boot as the default kernel,
    the next time reboot will boot it automatically.

