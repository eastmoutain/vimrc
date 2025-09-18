# get BMC address
If you can ssh to the machine, you can get the BMC address by running the following command:
```
ipmitool lan print 1 | grep "IP Address"
```

You need to install impitool on your machine.
For ubuntu, you can install it by running the following command:
```sh
sudo apt-get install ipmitool
```

# Power operation
- Power on
```sh
ipmitool -I lanplus -H <bmc_address> -U <username> -P <password>  power on
```
- Power off
```sh
ipmitool -I lanplus -H <bmc_address> -U <username> -P <password>  power off
```
- Reset
```sh
ipmitool -I lanplus -H <bmc_address> -U <username> -P <password>  power reset
```

# serial console ouptut
Connect to BMC serial console
```sh
ipmitool -I lanplus -H <bmc_address> -U <username> -P <password> sol activate
```
exit the console with "~." 
