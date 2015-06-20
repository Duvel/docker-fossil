#!/bin/sh
docker build -t duvel/rpi-fossil-builder . && docker run duvel/rpi-fossil-builder | docker build -t duvel/rpi-fossil -
