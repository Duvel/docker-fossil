Simple, high-reliability, distributed software configuration management system, also for the Raspberry Pi.

Based on [nijtmans/fossil](https://registry.hub.docker.com/u/nijtmans/fossil/). Moved from [duvel/rpi-fossil](https://registry.hub.docker.com/u/duvel/rpi-fossil/) as there is now also an `amd64` image available.

The fossil repository for this image is hosted on [https://docker-fossil.omloper.nl/](https://docker-fossil.omloper.nl/) and mirrored to GitHub. Check this article out for more info: [How To Mirror A Fossil Repository On GitHub](https://www.fossil-scm.org/home/doc/trunk/www/mirrortogithub.md).

Tested on a Raspberry Pi 2 B, 3 B en 3 B+.

You can start it with:

    sudo docker run -d -p 8080:8080 duvel/fossil

username = “admin”, password = “????”.

You can retrieve the password with:

    sudo docker logs <container>

# Host existing repository

## Add repository

    sudo mv duvel.fossil fossils
    sudo chown fossil:fossil fossils/duvel.fossil

## Run container

    docker run -d -p 80:8080 -v /home/pi/fossils/duvel.fossil:/opt/fossil/repository.fossil --name duvel duvel/fossil
