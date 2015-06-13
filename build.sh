#!/bin.sh
docker build -t rpi-fossil-builder . && docker run rpi-fossil-builder | docker build -t duvel/rpi-fossil -
