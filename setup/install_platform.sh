#!/usr/bin/env bash
set -e

FEDORA_PACKAGES=(
  make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
  openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-libs libnsl2 \
  lm_sensors
)

UBUNTU_PACKAGES=(
  make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl git \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
  lm-sensors
)

EXTRA_PACKAGES=(
  vim git tmux xclip jq curl htop iotop iftop python3-pip fzf ripgrep cloc tree zip unzip
)

# Detect distro via /etc/os-release
. /etc/os-release
echo "Detecting distro..."
if grep -qi "fedora" /etc/os-release; then
    DISTRO="fedora"
elif grep -qi "ubuntu" /etc/os-release; then
    DISTRO="ubuntu"
elif grep -qi "linuxmint" /etc/os-release; then
    DISTRO="linuxmint"
else
    echo "Unknown distro. Installation aborted."
    exit 1
fi

echo "Detected distro: $NAME ($ID)"

case $DISTRO in
    fedora)
        sudo dnf update -y
        sudo dnf install -y "${FEDORA_PACKAGES[@]}" "${EXTRA_PACKAGES[@]}"
        ;;
    ubuntu)
        sudo apt update -y
        sudo apt install -y "${UBUNTU_PACKAGES[@]}" "${EXTRA_PACKAGES[@]}"
        ;;
    linuxmint)
        sudo apt update -y
        sudo apt install -y "${UBUNTU_PACKAGES[@]}" "${EXTRA_PACKAGES[@]}"
        ;;
esac
