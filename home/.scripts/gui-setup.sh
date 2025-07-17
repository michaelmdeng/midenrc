#!/bin/bash
set -euo pipefail

# Basic GUI
sudo apt install -y baobab gnome-tweak-tool

# Dropbox
sudo apt install -y libatomic1
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -

# Keepass
sudo apt install -y xdotool keepass2

# touchpad gestures
sudo apt install -y xdotool libinput-tools
sudo gem install fusuma

# CopyQ clipboard manager
sudo apt install -y copyq
