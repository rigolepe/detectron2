FROM detectron2:v0

ENV NB_USER appuser
RUN sudo mkdir -p /work && \
    sudo chown $NB_USER /work

RUN pip install --user jupyter notebook

ENV PYTHONPATH='/work/:$PYTHONPATH'

WORKDIR /work

EXPOSE 8888

CMD jupyter notebook --port=8888 --ip=0.0.0.0
