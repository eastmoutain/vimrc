
# setup docker proxy
edit /etc/systemd/system/docker.service.d/http_proxy.conf
```sh
[Service]
Environment="HTTP_PROXY=http://10.61.40.54:7890"
Environment="HTTPS_PROXY=http://10.61.40.54:7890"
```

# setup docker registry
docker registry: Reference: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-22-04
ngnix: https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04


## create repistry dir
```sh
mkdir ~/docker-registry
cd ~/docker-registry
mkdir data
touch docker-compose.yml
```
## config
edit docker-compose.yml
```sh
version: '3'

services:
  registry:
    restart: always
    image: registry:2
    ports:
    - "5000:5000"
    environment:
      REGISTRY_AUTH: htpasswd
      REGISTRY_AUTH_HTPASSWD_REALM: Registry
      REGISTRY_AUTH_HTPASSWD_PATH: /auth/registry.password
      REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY: /data
    volumes:
      - ./auth:/auth
      - ./data:/data
```

## setup nginx port forwarding
Install nginx
```sh
sudo apt update
sudo apt install nginx
sudo ufw allow 'Nginx HTTP'
sudo ufw status
systemctl status nginx
```

edit /etc/nginx/sites-available/default, add the following in location section
```sh
    location / {
        # Do not allow connections from docker 1.5 and earlier
        # docker pre-1.6.0 did not properly set the user agent on ping, catch "Go *" user agents
        if ($http_user_agent ~ "^(docker\/1\.(3|4|5(?!\.[0-9]-dev))|Go ).*$" ) {
          return 404;
        }

        proxy_pass                          http://localhost:5000;
        proxy_set_header  Host              $http_host;   # required for docker client's sake
        proxy_set_header  X-Real-IP         $remote_addr; # pass on real client's IP
        proxy_set_header  X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header  X-Forwarded-Proto $scheme;
        proxy_read_timeout                  900;
    }
```
then
```sh
sudo systemctl restart nginx
docker compose up
```
## Setting Up Authentication
```sh
sudo apt install apache2-utils -y
mkdir ~/docker-registry/auth
cd ~/docker-registry/auth
htpasswd -Bc registry.password username
# To add more users, re-run the previous command without -c:
# htpasswd -B registry.password username
docker compose up
```

## Starting Docker Registry as a Service
edit docker-compose.yml, add the following
```sh
...
  registry:
    restart: always
...
```
then
```sh
docker compose up -d
```

## Increasing File Upload Size for Nginx
edit  /etc/nginx/nginx.conf
```sh
...
http {
        client_max_body_size 16384m;
        ...
}
...
```
then
```sh
sudo systemctl restart nginx
```
## allow other client access the docker_register
edit /etc/docker/daemon.json on client, add the following

```sh
{ "insecure-registries":["docker_registry_ip:5000"] }
```
otherwise, it may throw error info:
```
Using default tag: latest
Error response from daemon: Head "http://172.21.22.37:5000/v2/test-image/manifests/latest": no basic auth credentials
```

## Publishing to Your Private Docker Registry
```
# download ubuntu contaniner from docker hub
docker run -t -i ubuntu /bin/bash

# create a new images
docker commit $(docker ps -lq) test-image

# login in local docker registry
docker login https://docker_registry_ip:5000

# tag the image
docker tag test-image docker_registry_ip:5000/test-image

# push the image
docker push docker_registry_ip:5000/test-image
```

## pull images from local registry
```sh
 docker pull docker_registry_ip:5000/test-image
```
error info:
```
Using default tag: latest
Error response from daemon: Head "http://172.21.22.37:5000/v2/ubuntu_2204/manifests/latest": no basic auth credentials
```

Solution: edit /etc/docker/daemon.json, insert the following line:
```sh
{ "insecure-registries":["docker_registry_ip:5000"] }
```


