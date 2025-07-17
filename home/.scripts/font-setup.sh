#!/bin/bash
set -euo pipefail

DOWNLOAD_DIR="$(mktemp -d)"
trap 'rm -rf "${DOWNLOAD_DIR}"' EXIT

FONT_DIR="$HOME/Library/Fonts"
mkdir -p "$FONT_DIR"

# Iosevka Term
wget -P "$DOWNLOAD_DIR" https://github.com/be5invis/Iosevka/releases/download/v2.3.2/02-iosevka-term-2.3.2.zip
unzip -d "$DOWNLOAD_DIR/02-iosevka-term-2.3.2" "$DOWNLOAD_DIR/02-iosevka-term-2.3.2.zip"
find "$DOWNLOAD_DIR/02-iosevka-term-2.3.2/ttf" -name '*.ttf' -exec mv {} "$FONT_DIR" \;

# IBM Plex Mono
wget -P "$DOWNLOAD_DIR" https://github.com/IBM/plex/releases/download/v3.0.0/TrueType.zip
unzip -d "$DOWNLOAD_DIR" "$DOWNLOAD_DIR/TrueType.zip"
find "$DOWNLOAD_DIR/TrueType/IBM-Plex-Mono" -name '*.ttf' -exec mv {} "$FONT_DIR" \;

# Fira Sans Condensed
wget -P "$DOWNLOAD_DIR" https://github.com/mozilla/Fira/archive/4.202.zip
unzip -d "$DOWNLOAD_DIR" "$DOWNLOAD_DIR/4.202.zip"
find "$DOWNLOAD_DIR/Fira-4.202/ttf" -name '*.ttf' -exec mv {} "$FONT_DIR" \;
