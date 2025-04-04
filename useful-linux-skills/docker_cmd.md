# docker cmd

1. pull

2. push

3. run

	direct run into container bash. once you exit the container, the container will terminated. The changes will be lost if you don't commit the container.

	```sh
	// docker run -it REPOSITORY:TAG or docker run -it IMAGE ID
	$ docker run -it openanolis/anolisos:8-new bash
	// or
	$ docker run -it 00e09b719678 bash
	```

	run in detached mode

	```sh
	$ docker run -d -it openanolis/anolisos:8-new
	or 
	$ docker run -d -it IMAGE ID
	
	$ docker ps
	CONTAINER ID   IMAGE                       COMMAND   CREATED         STATUS           NAMES
	046955c00727   openanolis/anolisos:8-new   "bash"    3 seconds ago   Up 3 seconds   romantic_rosalind
	
	$ docker exec 046955c00727 bash
	[root@046955c00727 /]#
	```

4. stop

	stop a running container

	```sh
	$ docker ps
	CONTAINER ID   IMAGE                       COMMAND   CREATED         STATUS           NAMES
	046955c00727   openanolis/anolisos:8-new   "bash"    4 minutes ago   Up 4 minutes   romantic_rosalind
	
	$ docker stop 046955c00727
	$ docker ps
	CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
	```

	

5. list images

6. list running containers

7. commit

	```sh
	$ docker ps
	CONTAINER ID   IMAGE                  COMMAND   CREATED           STATUS             NAMES
	2b14080162fa   openanolis/anolisos:8  "bash"    About an hour ago Up About an hour  tender_chebyshev
	
	$ docker commit 2b14080162fa  openanolis/anolisos:8-new
	```

	You can commit with a change in cmdline.

	```sh
	docker commit --change "ENV DEBUG=true" 2b14080162fa  openanolis/anolisos:8-new
	```

	

8. mount dir

	Add `-v /host/dir:/container/dir` to mount host dir to container

	```sh
	-v /host/dir:/container/dir
	```

	

9. export network port

	Add `-p HOST_PORT:CONTAINER_PORT ` to export host port to container port

	```sh
	-p HOST_PORT:CONTAINER_PORT 
	```

	

10. delete images

11. config network proxy

12. set image location

13. set container user

14. set container workspace

15. login with ssh

16. docker build

	Write a docker file, then build the docker file. 

	```sh
	FROM openanolis/anolisos:8.2-x86_64
	run yum -y update
	RUN yum -y install openssh-server sudo vim make
	RUN yum -y groupinstall "Development Tools"
	RUN useradd -m dsh && echo dsh:qwer1234 | chpasswd
	
	RUN /usr/bin/ssh-keygen -A
	EXPOSE 22
	RUN rm -rf /run/nologin
	CMD /usr/sbin/sshd -D
	```

	build the docker file

	```sh
	docker build -t local/anolis8 .
	```

	

	then run the docker in detached mode.  If not in detached mode,  sshd wouldn't run instead of bash.

	```sh
	docker run -it -d -p 2345:22 local/anolis8:latest
	```

	connect to the docker with command

	```sh
	ssh -p 2345 dsh@localhost
	```

	