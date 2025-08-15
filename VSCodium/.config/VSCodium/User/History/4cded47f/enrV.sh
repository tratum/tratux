#!/bin/bash

wallDIR="$HOME/Wallpapers"
rofiThemeDIR="$HOME/.config/WallpaperSelector/wallpaper-selector.rasi"
FPS=60
TYPE="any"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

mapfile -d '' PICS < <(find -L "${wallDIR}" -type f \( \
  -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0)

if [ ${#PICS[@]} -gt 0 ]; then
  RANDOM_INDEX=$((RANDOM % ${#PICS[@]}))
  RANDOM_PIC="${PICS[$RANDOM_INDEX]}"
  RANDOM_PIC_NAME=$(basename "$RANDOM_PIC")
fi

menu() {
  IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))
  if [ -n "$RANDOM_PIC" ]; then
    printf "%s\x00icon\x1f%s\n" "$RANDOM_PIC_NAME" "$RANDOM_PIC"
  fi

  for pic_path in "${sorted_options[@]}"; do
    pic_name=$(basename "$pic_path")
    label=$(echo "$pic_name" | cut -d. -f1)
    printf "%s\x00icon\x1f%s\n" "$label" "$pic_path"
  done
}

selected=$(menu | rofi -dmenu -i -theme "$rofiThemeDIR" -p "Select Wallpaper:" | xargs)

selected_path=""
if [[ "$selected" == "$RANDOM_PIC_NAME" ]]; then
  selected_path="$RANDOM_PIC"
else
  for pic in "${PICS[@]}"; do
    if [[ "$(basename "$pic" | cut -d. -f1)" == "$selected" ]]; then
      selected_path="$pic"
      break
    fi
  done
fi

if [ -n "$selected_path" ]; then
  if ! pgrep -x "swww-daemon" >/dev/null; then
    swww-daemon --format xrgb &
    sleep 1  
  fi
  swww img "$SWWW_PARAMS" "$selected_path"
  ln -sf "$selected_path" "$HOME/.config/.current_wallpaper"
  if [ "$( < ~/.config/.current_theme )" = "dark" ]; then ~/.config/sway/scripts/theme.sh -d; else ~/.config/sway/scripts/theme.sh -l;
  fi
fi