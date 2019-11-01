#!/bin/bash

mkdir ~/.fonts

# Iosevka Term
wget https://github.com/be5invis/Iosevka/releases/download/v2.3.2/02-iosevka-term-2.3.2.zip
unzip 02-iosevka-term-2.3.2.zip 02-iosevka-term-2.3.2
mv 02-iosevka-term-2.3.2/ttf/*.ttf ~/.fonts

# IBM Plex Mono
wget https://github.com/IBM/plex/releases/download/v3.0.0/TrueType.zip
unzip TrueType.zip
mv TrueType/IBM-Plex-Mono/*.ttf ~/.fonts

# Fira Sans Condensed
wget https://github.com/mozilla/Fira/archive/4.202.zip
unzip 4.202.zip
mv Fira-4.202/ttf/*.ttf ~/.fonts
