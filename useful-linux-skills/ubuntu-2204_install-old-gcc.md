
The latest ubuntu such as ubuntu 2204 or 2210 can't install old version
gcc and g++ below version 8, to this end, add the following source
to  `/etc/apt/sources.list`

```sh
deb [arch=amd64] http://archive.ubuntu.com/ubuntu focal main universe
```
and 

```sh
$ sudo apt update
$ sudo apt install gcc-7 g++-7
```

