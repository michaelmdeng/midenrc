#!/usr/bin/env bash

set -eu pipefail -x

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME"/.fzf && "$HOME"/.fzf/install --all

# bat
curl --output-dir apps -LO https://github.com/sharkdp/bat/releases/download/v0.23.0/bat_0.23.0_amd64.deb
sudo dpkg -i apps/bat_0.23.0_amd64.deb

# rg
curl --output-dir apps -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i apps/ripgrep_13.0.0_amd64.deb

# mdcli
mkdir Source
git clone https://github.com/michaelmdeng/mdcli.git "$HOME"/Source
