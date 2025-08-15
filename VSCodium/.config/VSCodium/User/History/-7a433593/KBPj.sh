#!/bin/bash

#Variables
SDDM_DIR="/usr/share/sddm/themes/sddm-theme/metadata.desktop"
THEME_DIR="$HOME/.config/.current_theme"

THEME=$(<"$THEME_DIR")
THEME=$(echo "$THEME_DIR" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

case "$THEME" in
    dark)
        sudo sed -i "9 cConfigFile=Themes/dark.conf" "$SDDM_DIR"
    ;;
    light)
        sudo sed -i "9 cConfigFile=Themes/light.conf" "$SDDM_DIR"
    ;;
esac