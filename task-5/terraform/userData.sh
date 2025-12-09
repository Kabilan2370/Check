#!/bin/bash

# Install 4GB swap file
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
# Make swap permanent
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# update the apt
sudo apt update -y

# Add the docker GPG keys
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \

sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install docker
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Create a docker user
sudo usermod -aG docker ubuntu

sudo systemctl enable docker
sudo systemctl start docker

sudo docker pull kabilan2003/strapicustom:3.2
sudo docker run -d --name web1 -p 1337:1337 kabilan2003/strapicustom:3.2