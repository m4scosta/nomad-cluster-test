#!/bin/bash

rm /var/run/docker.pid
service docker start
consul agent -config-file=/etc/consul.d/config.json &
nomad agent -config=/etc/nomad.d
