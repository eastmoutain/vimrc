# update system date

## set system time manually
```sh
sudo date +%Y%m%d -s "20240801"
date +%T -s "11:49:13"
```

# udpate system time with one command
```sh
sudo date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"
```
# update system time to hardware clock
```sh
sudo hwclock -w --localtime
```
