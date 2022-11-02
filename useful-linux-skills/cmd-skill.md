# directory

- adding file into initramfs



## adding file into initramfs
- create a hook file in `/usr/share/initramfs-tools/hooks/xxx`
  for example, copy ctags from `/usr/local/bin` to `/bin` of initramfs
  we create a file `/usr/share/initramfs-tools/hooks/ctags`
  
  ```sh
  #!/bin/sh -e
  PREREQS=""
  case $1 in
        prereqs) echo "${PREREQS}"; exit 0;;
  esac
  . /usr/share/initramfs-tools/hook-functions
  copy_exec /usr/local/bin/ctags /bin
  ```
  
- grant the file with executable privilege

  ```sh
  $ sudo chmod +x /usr/share/initramfs-tools/hooks/ctags
  ```

    
- generate initramfs
  ```sh
  $ mkinitramfs -o ramfs.img
  ```

## dump Linux ACPI Table

- dump ACPI table in binaray file
    ```sh
    $ sudo acpidump -b
    ```

- translate the binary file into text file
    ```sh
    $ iasl -d ivrs.dat
    ```
