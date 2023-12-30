
#The file guids how to dump page table of user process or kernel

build kernel with CONFIG_PTDUMP_CORE and CONFIG_PTDUMP_DEBUGFS enabled
```sh
scripts/config --file .config --enable CONFIG_PTDUMP_CORE
scripts/config --file .config --enable CONFIG_PTDUMP_DEBUGFS
```

dump kernel page table
    ```sh
    $ cat /sys/kernel/debug/page_tables/kernel | more
    ```

dump user page table by pid
    ```sh
    $ echo pid > /proc/sys/debug/pgt_dump_process_id
    $ cat /sys/kernel/debug/page_tables/user | more
    ```

