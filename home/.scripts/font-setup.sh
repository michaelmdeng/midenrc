#!/bin/bash

DOWNLOAD_DIR="~/Downloads"
mkdir ~/.fonts

# Iosevka Term
wget -P $DOWNLOAD_DIR https://github.com/be5invis/Iosevka/releases/download/v2.3.2/02-iosevka-term-2.3.2.zip
unzip -d "$DOWNLOAD_DIR/02-iosevka-term-2.3.2" ~/Downloads/02-iosevka-term-2.3.2.zip 
mv "$DOWNLOAD_DIR/02-iosevka-term-2.3.2/ttf/*.ttf" ~/.fonts

# IBM Plex Mono
wget -P $DOWNLOAD_DIR https://github.com/IBM/plex/releases/download/v3.0.0/TrueType.zip
unzip -d $DOWNLOAD_DIR "$DOWNLOAD_DIR/TrueType.zip"
mv "$DOWNLOAD_DIR/TrueType/IBM-Plex-Mono/*.ttf" ~/.fonts

# Fira Sans Condensed
wget -P $DOWNLOAD_DIR https://github.com/mozilla/Fira/archive/4.202.zip
unzip -d $DOWNLOAD_DIR "$DOWNLOAD_DIR/4.202.zip"
mv "$DOWNLOAD_DIR/Fira-4.202/ttf/*.ttf" ~/.fonts
