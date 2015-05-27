Based on [nijtmans/fossil](https://registry.hub.docker.com/u/nijtmans/fossil/).

Simple, high-reliability, distributed software configuration management system, build for the Raspberry Pi.

Tested on a Raspberry Pi B and a 2 B.

You can start it with:

    sudo docker run -d -p 8080:8080 duvel/rpi-fossil

username = “admin”, password = “????”.

You can retrieve the password with:

    sudo docker logs <container>

# Host existing repository
## Prepare docker host

	sudo su
	groupadd -r fossil -g 433 && useradd -u 431 -r -g fossil -d /opt/fossil -s /sbin/nologin -c "Fossil user" fossil
	mkdir fossils
	chown fossil:fossil fossils
	exit

## Add repository

    sudo mv duvel.fossil fossils
    sudo chown fossil:fossil fossils/duvel.fossil

## Run container
	docker run -d -p 80:8080 -v /home/pi/fossils/duvel.fossil:/opt/fossil/repository.fossil --name duvel duvel/rpi-fossil