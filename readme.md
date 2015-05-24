## Prepare docker host

	sudo su
	groupadd -r fossil -g 433 && useradd -u 431 -r -g fossil -d /opt/fossil -s /sbin/nologin -c "Fossil user" fossil
	exit
	mkdir fossils
	chown fossil:fossil fossils

## Run container
	docker run -d -p 80:8080 -v /home/pi/fossils/remco.fossil:/opt/fossil/repository.fossil --name remco rpi-fossil