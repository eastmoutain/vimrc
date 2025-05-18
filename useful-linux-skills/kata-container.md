# Basic operations

## Delete pod

* delete container
```sh
kubectl delete pod POD_NAME
```

* delete daemonset
```sh
kubectl delete deamonset pod POD_NAME -n kube-system
```


## Connect to guest console
1. enable debug in the toml file
```sh
debug_console_enabled = true
```

2. connect to guest console
```sh
kata-runtime exec Conatainer-ID
```
You can find container-ID at /var/run/vc/vm/Container-ID

