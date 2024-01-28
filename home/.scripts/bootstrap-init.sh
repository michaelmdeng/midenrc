#!/usr/bin/env bash

set -eu pipefail -x

git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
$HOME/.homesick/repos/homeshick/bin/homeshick -q clone https://github.com/michaelmdeng/midenrc.git
cd $HOME/.homesick/repos/midenrc && git checkout airbnb

cd $HOME
mkdir apps

# nvim
wget -O apps/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/v0.9.2/nvim-linux64.tar.gz
tar -x -f apps/nvim-linux64.tar.gz -C apps
export PATH="$PATH:$HOME/apps/nvim-linux64/bin"

# bat
curl --output-dir apps -LO https://github.com/sharkdp/bat/releases/download/v0.23.0/bat_0.23.0_amd64.deb
sudo dpkg -i apps/bat_0.23.0_amd64.deb

# rg
curl --output-dir apps -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i apps/ripgrep_13.0.0_amd64.deb

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf && $HOME/.fzf/install --all

# vim-plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# mdcli
mkdir Source
git clone https://github.com/michaelmdeng/mdcli.git $HOME/Source

# gopls
go install golang.org/x/tools/gopls@latest

# python
pip3 install --upgrade pip
pip3 install virtualenv virtualenvwrapper
pip3 install neovim sexpdata websocket-client

# python-nvim
mkvirtualenv --python=python3 nvim3
workon nvim3
pip3 install neovim sexpdata websocket-client
deactivate

$HOME/apps/nvim-linux64/bin/nvim +PlugInstall
$HOME/apps/nvim-linux64/bin/nvim +UpdateRemotePlugins

$HOME/.homesick/repos/homeshick/bin/homeshick link midenrc -f

# tpm
git clone https://github.com/tmux-plugins/tpm $HOME/tmux/plugins/tpm
$HOME/tmux/plugins/tpm/bin/install_plugins
