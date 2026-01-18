# Install Docker Engine on Linux Mint 22.3

These instructions are tailored for Linux Mint 22.3 (Zena), which is based on statistics Ubuntu 24.04 (Noble Numbat).

## prerequisites

Remove any conflicting packages:

```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

## 1. Set up Docker's `apt` repository

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
# Note: Linux Mint 22.3 is based on Ubuntu Noble, so we use "noble" as the codename.
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  noble stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

## 2. Install the Docker packages

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## 3. Verify Installation

Check that Docker is installed correctly by running the `hello-world` image:

```bash
sudo systemctl start docker
sudo docker run hello-world
```

## 4. Linux Post-installation Steps (Optional)

Manage Docker as a non-root user (so you don't have to type `sudo` before every docker command).

```bash
# Create the docker group (if it doesn't exist)
sudo groupadd docker

# Add your user to the docker group
sudo usermod -aG docker $USER

# Activate the changes to groups
newgrp docker
```

Verify that you can run `docker` commands without `sudo`:

```bash
docker run hello-world
```
If you see the "Hello from Docker!" message, then the installation was successful!