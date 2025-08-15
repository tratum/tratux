#!/bin/bash

wallDIR="$HOME/Wallpapers"
mapfile -t PICS < <(
  find -L "$wallDIR" -maxdepth 1 -mindepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \)
)

if (( ${#PICS[@]} == 0 )); then
  echo "No wallpapers found in $wallDIR" >&2
  exit 1
fi

RANDOMPICS="${PICS[RANDOM % ${#PICS[@]}]}"
selected_path="$RANDOMPICS"

FPS=60
TYPE="random"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS=(
  --transition-fps "$FPS"
  --transition-type "$TYPE"
  --transition-duration "$DURATION"
  --transition-bezier "$BEZIER"
)

if ! swww query &>/dev/null; then
  swww-daemon --format xrgb &
  sleep 1
fi

swww img "${SWWW_PARAMS[@]}" "$selected_path"
ln -sf "$selected_path" "$HOME/.config/.current_wallpaper"
if [[ "$( < ~/.config/.current_theme )" == "dark" ]]; then
  ~/.config/sway/scripts/theme.sh -d
else
  ~/.config/sway/scripts/theme.sh -l
fi