#!/bin/bash
set -euo pipefail

sudo apt install -y python3-dev python3-pip

# virtualenvs
pip install virtualenv virtualenvwrapper
pip3 install virtualenv virtualenvwrapper

# pyenv and plugins
curl https://pyenv.run | bash
export PYENV_ROOT="$HOME/.pyenv"
if [ ! -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]; then
  git clone https://github.com/pyenv/pyenv-virtualenv.git "$PYENV_ROOT/plugins/pyenv-virtualenv"
fi
if [ ! -d "$PYENV_ROOT/plugins/pyenv-virtualenvwrapper" ]; then
  git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git "$PYENV_ROOT/plugins/pyenv-virtualenvwrapper"
fi
