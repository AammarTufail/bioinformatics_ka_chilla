#!/bin/bash
set -e

# Docker Installation Script for Linux Mint 22.3 (based on Ubuntu Noble)

echo "Starting Docker installation..."

# 1. Uninstall old versions
echo "Removing old/conflicting packages..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt-get remove -y $pkg || true
done

# 2. Set up repository
echo "Setting up Docker repository..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Hardcoding 'noble' because Mint 22.3 is based on it
# and 'lsb_release -cs' would return 'zena'.
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  noble stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

# 3. Install Docker Engine
echo "Installing Docker Engine..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 4. Post-installation steps
echo "Configuring user permissions..."
sudo groupadd docker || true
sudo usermod -aG docker "$USER"
sudo systemctl start docker
sudo docker run hello-world

echo "Docker installation completed successfully."
echo "Please log out and back in to apply group changes, or run 'newgrp docker' to use docker immediately."
echo "You can verify installation with: docker run hello-world"
