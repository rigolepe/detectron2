#!/bin/bash

WORK=`pwd`

docker run -it --rm -v "$WORK":/work -p 8888:8888 dekr_jupyter_detectron2
