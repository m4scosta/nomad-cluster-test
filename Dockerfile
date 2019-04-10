FROM ubuntu:18.04

WORKDIR /

RUN apt update && apt install -y curl jq unzip iproute2 docker.io

ADD install_nomad.sh /

RUN ./install_nomad.sh
