FROM jupyter_detectron2


ENV NB_USER appuser

RUN sudo mkdir -p /src && \
    sudo chown $NB_USER /src

ENV DEBIAN_FRONTEND noninteractive
RUN sudo apt-get update && sudo apt-get install -y \
	unzip


ENV POSE_ROOT /src/DEKR

RUN cd /src && \
    git clone https://github.com/HRNet/DEKR.git && \
    cd $POSE_ROOT && \ 
    pip install -r requirements.txt


ENV COCOAPI /src/cocoapi

RUN cd /src && \
    git clone https://github.com/cocodataset/cocoapi.git && \
    cd $COCOAPI/PythonAPI && \
    # Install into global site-packages
    # sudo make install && \
    # Alternatively, if you do not have permissions or prefer
    # not to install the COCO API into global site-packages
    python3 setup.py install --user && \
    cd /src


ENV CROWDPOSEAPI /src/CrowdPose

RUN cd /src && \
    git clone https://github.com/Jeff-sjtu/CrowdPose.git && \ 
    cd $CROWDPOSEAPI/crowdpose-api/PythonAPI && \
    # sudo make install && \
    python3 setup.py install --user && \
    cd /src


RUN --mount=type=secret,id=driveapi,dst=/driveapi cd $POSE_ROOT && \ 
    mkdir output && \ 
    mkdir log && \
    # Download the model from Google Drive or change this dockerfile to copy the model file you can download from this location:
    # https://mailustceducn-my.sharepoint.com/personal/aa397601_mail_ustc_edu_cn/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Faa397601%5Fmail%5Fustc%5Fedu%5Fcn%2FDocuments%2FDEKR%2DDisentangled%2DKeypoint%2DRegression&originalPath=aHR0cHM6Ly9tYWlsdXN0Y2VkdWNuLW15LnNoYXJlcG9pbnQuY29tLzpmOi9nL3BlcnNvbmFsL2FhMzk3NjAxX21haWxfdXN0Y19lZHVfY24vRW1vTndOcHE0TDFGZ1VzQzlLYldlekFCU290ZDNCR09sY1dDZGtCaTkxbDUwZz9ydGltZT1iV1BVbGxNNTJVZw
    wget "https://www.googleapis.com/drive/v3/files/1To2wq6xworErFwLgkV-MYSQx3ZyvrDL_?alt=media&key=$(sudo cat /driveapi)" -O model.zip && \
    unzip model.zip && \ 
    rm model.zip 

ENV PYTHONPATH="${POSE_ROOT}:${PYTHONPATH}"
ENV PYTHONPATH="${POSE_ROOT}/lib:${PYTHONPATH}"
