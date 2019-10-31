#!/bin/bash

sudo apt install python3-dev python3-pip

# virtualenvs
pip install virtualenv virtualenvwrapper
pip3 install virtualenv virtualenvwrapper

# pyenv and plugins
curl https://pyenv.run | bash
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper
