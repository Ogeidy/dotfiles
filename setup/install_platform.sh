#!/usr/bin/env bash
set -e

FEDORA_PACKAGES=(
  vim git tmux xclip jq curl htop iotop iftop python3-pip
)

UBUNTU_PACKAGES=(
  vim git tmux xclip jq curl htop iotop iftop python3-pip
)

EXTRA_PACKAGES=(
  fzf ripgrep cloc tree zip unzip
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
