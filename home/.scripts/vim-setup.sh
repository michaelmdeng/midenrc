#!/bin/bash

sudo apt install neovim python3-neovim

# nvim on global Python
pip3 install sexpdata websocket-client

# nvim on custom virtualenv
mkvirtualenv --python=python3 nvim3
workon nvim3
pip3 install sexpdata websocket-client
pip3 install pylint black
deactivate

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -E -c UpdateRemotePlugins -c PlugInstall -c q

