#!/bin/bash

# Install Docker
#https://docs.docker.com/engine/installation/linux/docker-ce/fedora/

# Empty for latest stable version
DOCKER_VERSION=""
#DOCKER_VERSION=-17.12.0.ce-1.fc27

COMPOSE_VERSION="1.25.4"

sudo dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-selinux \
                docker-engine-selinux \
                docker-engine

# Version can be shown by using the `dnf list --showduplicates`
#sudo dnf list docker-ce  --showduplicates | sort -r
sudo dnf install docker-ce${DOCKER_VERSION}

sudo systemctl enable docker
sudo systemctl start docker

# Append user to docker groups
sudo usermod -a `whoami` -G docker

# Install docker-compose
#https://docs.docker.com/compose/install/#install-compose
sudo curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
