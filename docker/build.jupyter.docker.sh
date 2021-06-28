#!/bin/bash

docker rmi -f jupyter_detectron2

docker build -t jupyter_detectron2 -f jupyter.Dockerfile .
