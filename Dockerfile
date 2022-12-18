FROM ubuntu
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y python3.8 python3.8-distutils wget ghostscript python3-tk ffmpeg libsm6 libxext6 git python3.8-dev libpq-dev build-essential
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.8 get-pip.py
RUN git clone https://www.github.com/camelot-dev/excalibur
RUN pwd
RUN pip install /excalibur
RUN sed -i 's/from camelot.ext.ghostscript import Ghostscript/from ghostscript import Ghostscript/' /usr/local/lib/python3.8/dist-packages/excalibur/tasks.py
RUN pip install itsdangerous==2.0.1 Jinja2==3.0.3 celery==4.1.1 psycopg2 Redis
COPY docker-excalibur.cfg /root/excalibur/excalibur.cfg 
#RUN excalibur initdb
#ENTRYPOINT excalibur webserver
EXPOSE 5000
