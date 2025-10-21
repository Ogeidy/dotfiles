#!/usr/bin/env bash
set -e

PYENV_ROOT="${HOME}/.pyenv"
export PYENV_ROOT="${PYENV_ROOT}"
export PATH="${PYENV_ROOT}/bin:${PATH}"

if [ -d "${PYENV_ROOT}" ]; then
  echo "pyenv already installed at ${PYENV_ROOT}"
else
  echo "Cloning pyenv..."
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

source ~/.bashrc

LATEST_PYTHON=$(pyenv install --list | grep -E " 3\.[0-9]+\.[0-9]+$" | tail -1 | xargs)
echo "Installing Python ${LATEST_PYTHON} via pyenv..."
pyenv install -s "$LATEST_PYTHON"
pyenv global "$LATEST_PYTHON"
echo "Python installed: $(python --version)"
