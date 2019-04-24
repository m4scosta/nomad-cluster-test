FROM ubuntu:18.04

WORKDIR /

RUN apt update && apt install -y curl jq unzip iproute2 docker.io

ADD scripts/install_nomad.sh .
ADD scripts/install_consul.sh .

RUN ./install_nomad.sh
RUN ./install_consul.sh

ADD scripts/cmd_script.sh .

ENTRYPOINT ./cmd_script.sh
