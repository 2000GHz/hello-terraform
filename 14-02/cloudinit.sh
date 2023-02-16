#!/bin/sh
amazon-linux-extras install -y docker
service docker start
systemctl enable docker
usermod -a -G docker ec2-user
pip3 install docker-compose
wget https://raw.githubusercontent.com/2000GHz/hello-2048/master/docker-compose.yaml
docker-compose pull
docker-compose up -d