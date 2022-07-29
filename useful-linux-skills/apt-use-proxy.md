1. edit /etc/apt/apt.conf.d/proxy.conf, add the following two lines in it

```sh
Acquire::http::Proxy "http://172.21.21.37:7890";
Acquire::https::Proxy "http://172.21.21.37:7890";
```

