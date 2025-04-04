# how to send mail from cmdline

## ubuntu: install mailutils
```sh
$ sudo apt install -y  mailutils postfix libsasl2-2 ca-certificates libsasl2-modules
```
then slect `OK`, then `Internet Site`

## send mail
```sh
$ $ echo "Hello world" | mail -s "Test" james@example.com
```
