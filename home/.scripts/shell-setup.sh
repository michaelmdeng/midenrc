#!/bin/bash

sudo apt update

# Basics
sudo apt install curl zlib1g-dev
sudo apt install vim neovim exuberant-ctags
sudo apt install ddgr jq mpv pandoc powertop taskwarrior

# Basic GUI
sudo apt install baobab gnome-tweak-tool

# Dropbox
sudo apt install libatomic1
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -

# Keepass
sudo apt install xdotool keepass2

sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# configuration stuff
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
$HOME/.homesick/repos/homeshick/bin/homeshick clone https://github.com/michaelmdeng/DotConfig.git

# tmux
sudo apt install tmux ruby
sudo gem install tmuxinator mdl
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# bat, not available in apt as of Ubuntu 18
wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb
sudo dpkg -i bat_0.12.1_amd64.deb

# ripgrep, not available in apt as of Ubuntu 18
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
