#!/usr/bin/env bash
set -e

NVM_DIR="${HOME}/.nvm"
if [ -d "${NVM_DIR}" ]; then
  echo "nvm already installed at ${NVM_DIR}"
else
  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# Load nvm in this script if possible
export NVM_DIR="${NVM_DIR}"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"

# Install latest LTS node
if command -v nvm >/dev/null 2>&1; then
  nvm install --lts
  nvm alias default 'lts/*'
else
  echo "nvm not found in this shell — please restart shell or source ~/.bashrc to use nvm"
fi