DOCKER_IMAGE_VERSION=2.13-alpine3.12-armv7
DOCKER_IMAGE_NAME=duvel/fossil
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
		docker build --no-cache -t $(DOCKER_IMAGE_TAGNAME) .
		docker tag  $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
		docker push $(DOCKER_IMAGE_TAGNAME)
