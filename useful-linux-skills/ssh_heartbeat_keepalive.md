How to keep ssh alive?

the solution is sending heartbeat between client and server

## Client 

config file: `/etc/ssh/ssh_config` or    `~/.ssh/config`

```sh
Host *
    ServerAliveInterval 300
    ServerAliveCountMax 2
```

## server

config file `/etc/ssh/sshd_config`

```sh
ClientAliveInterval 300
ClientAliveCountMax 2
```
