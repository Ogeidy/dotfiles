#!/usr/bin/env bash
set -e

. /etc/os-release

if command -v docker >/dev/null 2>&1; then
  echo "Docker is already installed"
  exit 0
fi

if [[ "$ID" == "fedora" ]]; then
  sudo dnf -y install dnf-plugins-core
  sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl enable --now docker
elif [[ "$ID" == "ubuntu" ]] || [[ "$ID" == "linuxmint" ]] || [[ "$ID_LIKE" == *"debian"* ]]; then
  sudo apt update -y
  sudo apt install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update -y

  # Install the Docker packages.
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl enable --now docker
else
  echo "Unknown distro: please install docker manually."
fi

# Add current user to docker group
if getent group docker >/dev/null 2>&1; then
  sudo usermod -aG docker "$USER" || true
  echo "Added $USER to docker group (you may need to relogin)"
fi
