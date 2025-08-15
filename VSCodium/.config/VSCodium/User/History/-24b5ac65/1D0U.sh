#!/bin/bash

#Variables
SDDM_DIR="/usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop"
THEME_DIR="$HOME/.config/.current_theme"

THEME=$(<"$THEME_DIR")
THEME=$(echo "$THEME_DIR" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

case "$THEME" in
    dark)
        