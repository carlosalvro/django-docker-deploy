# setting up base image
FROM python:3.11.5-slim-bullseye

# prevents python buffering stdout and stderr

ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# sets up the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions 
WORKDIR /app

# copies files and directories from current directory to WORKDIR
COPY . /app/

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt /app/
RUN pip install -r requirements.txt