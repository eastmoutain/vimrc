#/bin/bash


# usage:
# add line in crontab -e
# */5 * * * * curl -4 icanhazip.com
# */5 * * * * /usr/local/bin/update_public_ip.sh
 

ip4_addr=$(cat /etc/public_ip4_addr)
ip4_addr_old=$(cat /etc/public_ip4_addr_old)

echo "ip4_addr $ip4_addr, ip_addr_old $ip4_addr_old"
if [ -z $ip4_addr_old ]; then
	echo $ip4_addr > /etc/public_ip4_addr_old
else
    if [ $ip4_addr != $ip4_addr_old ]; then
        echo "new public IP:$ip4_addr" | mail -s "your raspberry pi IP changed" thomasyang1206@126.com
	echo $ip4_addr > /etc/public_ip4_addr_old
	echo "send mail"
    fi
fi
