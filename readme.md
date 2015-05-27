

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