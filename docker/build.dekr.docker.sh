#!/bin/bash

docker rmi -f dekr_jupyter_detectron2

# point the GOOGLE_API_KEY env variable to the file that contains the Google API key that can access the drive containing the model file. 
docker build -t dekr_jupyter_detectron2 -f dekr.Dockerfile --secret id=driveapi,src=$GOOGLE_API_KEY .
