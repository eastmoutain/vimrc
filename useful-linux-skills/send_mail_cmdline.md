# how to send mail from cmdline

## ubuntu: install mailutils
```sh
$ sudo apt install mailutils -y
```
then slect `OK`, then `Internet Site`

## send mail
```sh
$ $ echo "Hello world" | mail -s "Test" james@example.com
```
