FROM continuumio/miniconda:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update && apt-get install nano

RUN mkdir -p /backend

COPY ./backend/requirements.yml /backend/requirements.yml
RUN /opt/conda/bin/conda env create -f requirements.yml
ENV PATH /opt/conda/envs/backend/bin:$PATH

RUN echo "source activate backend" >~/.bashrc

COPY ./scripts /scripts
RUN chmod +x ./scripts*

COPY . /backend

WORKDIR /backend
