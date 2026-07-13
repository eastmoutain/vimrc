# 搭建frp反向代理

利用frp反向代理，在client和server之间建立网络连接，将client的端口映射到server，用户可以通过ssh 连接server建立第三方和client的ssh通路。

下载https://github.com/fatedier/frp/releases  0.68.0的安装包, 需要在server上和client上都下载。

## server端

例如frp安装在server的/opt/frp目录

```sh
tree /opt/frp
/opt/frp
├── frpc
├── frpc.toml
├── frps
├── frps.toml
└── LICENSE

0 directories, 5 files
```

编写一个/etc/systemd/system/frps.service，内容如下：

```sh
[Unit]
Description=FRP Server Service
After=network.target

[Service]
Type=simple
ExecStart=/opt/frp/frps -c /opt/frp/frps.toml
Restart=on-failure
RestartSec=5
WorkingDirectory=/opt/frp

[Install]
WantedBy=multi-user.target
```

frps.toml的内容：

```sh
# /opt/frp/frps.toml
bindPort = 7080
auth.method = "token"
auth.token = "YourStrongPassword123!"

# 可选：日志配置
log.to = "/var/log/frps.log"
log.level = "info"
log.maxDays = 7
```

使能serivce

```sh
sudo systemctl enable frps.service
sudo systemctl start frps.service
```



## client端

例如frp安装在client的/opt/frp目录

```sh
tree /opt/frp
/opt/frp
├── frpc
├── frpc.toml
├── frps
├── frps.toml
└── LICENSE

0 directories, 5 files
```

编写一个/etc/systemd/system/frpc.service，内容如下：

```sh
[Unit]
Description=FRP Client Service
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/opt/frp/frpc -c /opt/frp/frpc.toml
Restart=on-failure
RestartSec=5
WorkingDirectory=/opt/frp
LimitNOFILE=1048576
# User=frpc
# Group=frpc

[Install]
WantedBy=multi-user.target
```

/opt/frp/frpc.toml的内容如下：（记得将server ip替换成自己的server的公网ip)

```sh
# frpc.toml
serverAddr = "123.11.22.33" # server IP
serverPort = 7080
auth.method = "token"
auth.token = "YourStrongPassword123!"

# 示例1：穿透 SSH
[[proxies]]
name = "ssh"
type = "tcp"
localIP = "127.0.0.1"
localPort = 22
remotePort = 6000

```

使能sevice

```sh
sudo systemctl enable frpc.service
sudo systemctl start frpc.service
```



# 通过server 连接client

在第三方机器上，通过server建立和client的ssh链接（记得将server ip替换成自己的server的公网ip）

ssh -p 6000 user@server_ip 

输入client的user的密码，就可以登录到client机器。
