# How to use pip mirror in China with aliyun backend

- create a file named pip.conf in ~/.pip
- add the following content

```sh
[global]
trusted-host=mirrors.aliyun.com
index-url = http://mirrors.aliyun.com/pypi/simple
```
