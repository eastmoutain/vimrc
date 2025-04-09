# 配置harbor

# a example of harbor config of aliyun server

Refer to useful-linux-skills/harbor.yml

> Note: the server use a public IP and internal private IP, you should:
        1. set the public IP as hostname, and add `relativeurls: true`
           in http section.
        2. uncomment `external_url: http://public_ip`


# server

Reference: https://goharbor.io/docs/2.12.0/install-config/download-installer/



1. Download the online or offline installer for the version you want to install.

2. unpack the installer

	```sh
	tar xzvf harbor-offline-installer-version.tgz
	cd harbor
	```

3. copy `harbor.yml` from `harbor.yml.tmpl`, and update the config info accordingly.

	* set your server IP address or hostname. 

	```yml
	hostname: 10.59.41.49
	
	# http related config
	http:
	  # port for http, default is 80. If https enabled, this port will redirect to https port
	  port: 80
	```

	* http access only

		comment https configuration.

	```yml
	# https related config
	#https:
	#  # https port for harbor, default is 443
	#  port: 443
	#  # The path of cert and key files for nginx
	#  certificate: /your/certificate/path
	#  private_key: /your/private/key/path
	#  # enable strong ssl ciphers (default: false)
	#  # strong_ssl_ciphers: false
	```

	* set admin password

	```yml
	# The initial password of Harbor admin
	# It only works in first time to install harbor
	# Remember Change the admin password from UI after launching Harbor.
	harbor_admin_password: Harbor12345
	```

4. install

	```sh
	sudo ./install.sh
	```

5. reinstall

    ```sh
    sudo docker compose down -v
    # do some update
    sudo ./install.sh
    ```
	
# client

if you access the server with http, you need to config your client docker.  edit `/etc/docker/daemon.json`,  add the following:

```sh
{
        "insecure-registries" : ["10.59.41.49:80", "0.0.0.0/0"]
}
```
or 

```sh
{
        "insecure-registries" : ["10.59.41.49", "0.0.0.0/0"]
}
```

Then restart docker service

```sh
sudo systemctl daemon-reload
sudo systemctl restart docker
```



1. Login to docker hub

	```sh
	docker login -u admin -p Harbor12345 http://10.59.41.49
	```

	or 

	```
	docker login -u admin -p Harbor12345 http://10.59.41.49:80
	```

	

2. Prepare docker image.

	You should create a project in your harbor server in advance, say, `anolis`

	![image-20250407212917949](/Users/dsh/Library/Application Support/typora-user-images/image-20250407212917949.png)

	For example, you have a local image `local/anolis8.4:latest `, tag it with server address.

	```sh
	docker tag local/anolis8.4:latest 10.59.41.49:80/anolis/anolis8.4:latest
	```

	

3. Push image to docker hub

	```sh
	docker tag local/anolis8.4:latest 10.59.41.49:80/anolis/anolis8.4:latest
	docker push 10.59.41.49:80/anolis/anolis8.4
	```

4. Pull image 

	```sh
	docker pull 10.59.41.49:80/anolis/anolis8.4
	```

	

# 使用签名镜像

1. Download cosign binary from official release page `https://github.com/sigstore/cosign/releases`, then grant exectable perrmission.

	```sh
	mv cosign-linux-amd64 cosign
	chmod +x cosign
	```

2. generate key pair, you will be asked to input password for the key

	```sh
	./cosign generate-key-pair
	Enter password for private key:
	Enter password for private key again:
	Private key written to cosign.key
	Public key written to cosign.pub
	```

3. sign the image

	```sh
	./cosign sign --key cosign.key <harbor-instance>/<image/path>:<image-tag>
	```

	for example:

	```sh
	./cosign-linux-amd64 sign --key cosign.key 10.59.41.49/anolis/anolis8.4:latest
	Enter password for private key:
	WARNING: Image reference 10.59.41.49/anolis/anolis8.4:latest uses a tag, not a digest, to identify the image to sign.
	    This can lead you to sign a different image than the intended one. Please use a
	    digest (example.com/ubuntu@sha256:abc123...) rather than tag
	    (example.com/ubuntu:latest) for the input to cosign. The ability to refer to
	    images by tag will be removed in a future release.
	
	
		The sigstore service, hosted by sigstore a Series of LF Projects, LLC, is provided pursuant to the Hosted Project Tools Terms of Use, available at https://lfprojects.org/policies/hosted-project-tools-terms-of-use/.
		Note that if your submission includes personal data associated with this signed artifact, it will be part of an immutable record.
		This may include the email address associated with the account with which you authenticate your contractual Agreement.
		This information will be used for signing this artifact and will be stored in public transparency logs and cannot be removed later, and is subject to the Immutable Record notice at https://lfprojects.org/policies/hosted-project-tools-immutable-records/.
	
	By typing 'y', you attest that (1) you are not submitting the personal data of any other person; and (2) you understand and agree to the statement and the Agreement terms at the URLs listed above.
	Are you sure you would like to continue? [y/N] y
	tlog entry created with index: 193306545
	Pushing signature to: 10.59.41.49/anolis/anolis8.4
	```

	
