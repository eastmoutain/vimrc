
# set ulimit 
it's only functional to current termnial
```sh
$ ulimit -c unlimited
```

# set the core dump file path (optinal)
the default core dump file path is /var/lib/apport/coredump/ 

# check the name of core dump file
It will show the name of the core dump file
```sh
$ cat /var/log/apport.log
```

# debug the core dump file
For example, the core dump file is at 
```sh
$ gdb test.elf /var/lib/apport/coredump/core.xxx
```
