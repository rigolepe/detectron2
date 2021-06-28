#!/bin/bash

WORK=`pwd`

docker run -it --rm -v "$WORK":/work -p 8888:8888 jupyter_detectron2

# run from the jupyter folder! Otherwise detectron2 uses the local version, not the one in the docker container. 
# ➜  jupyter git:(master) ✗ ../docker/run.jupyter.docker.sh
