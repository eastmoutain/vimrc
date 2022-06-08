
## prepare

- armv7: Download clash-linux-armv7-v1.7.0.gz from  https://github.com/Dreamacro/clash/releases
- x86-64: Download clash-linux-amd64-v3-v1.10.6.gz from  https://github.com/Dreamacro/clash/releases

- Download clash-dashboard from git clone https://github.com/Dreamacro/clash-dashboard.git

### install clash(armv7)

1. extract clash from clash-linux-armv7-v1.7.0.gz with cmd:

```sh
$ gzip clash-linux-armv7-v1.7.0.gz -d /usr/local/bin/

# create a soft link for clash
$ ln -s /usr/local/bin/clash-linux-armv7-v1.7.0 /usr/local/bin/clash
```
2. run clash first time to generate default config dir and file

```sh
$ clash
```

### config ui

1. clone clash-dashboard

```sh
$ git clone https://github.com/Dreamacro/clash-dashboard.git
$ cd clash-dashboard 
$ git checkout -b gh-pages origin/gh-pages
```


### config ui

1. clone clash-dashboard

```sh
$ git clone https://github.com/Dreamacro/clash-dashboard.git
$ cd clash-dashboard 
$ git checkout -b gh-pages origin/gh-pages
```


### config ui

1. clone clash-dashboard

```sh
$ git clone https://github.com/Dreamacro/clash-dashboard.git
$ cd clash-dashboard 
$ git checkout -b gh-pages origin/gh-pages
```
2. change the config.yaml to display ui on remote web 

open the ~/.config/clash/config.yaml

```sh
external-controller: '192.168.1.111:8989'   # ip of respberry pi
```

then run clash with cmd
```sh
clash -ext-ui /home/pi/path-to-your/clash-dashboard 
```
you will see the ui from remote web address
```sh
192.168.1.111:8989/ui
```

