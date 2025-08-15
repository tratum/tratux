#!/bin/bash

wallDIR="$HOME/Wallpapers"
rofiThemeDIR="$HOME/.config/WallpaperSelector/wallpaper-selector.rasi"

mapfile -d '' ALL_PICS < <(
  find -L "$wallDIR" -maxdepth 1 -mindepth 1 \
       -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
       -print0
)
(( ${#ALL_PICS[@]} )) || {
  echo "No wallpapers found in $wallDIR" >&2
  exit 1
}

mapfile -t SHUFFLED_PICS < <(
  printf '%s\n' "${ALL_PICS[@]}" | shuf
)

declare -A lookup
menu_lines=()
for pic in "${SHUFFLED_PICS[@]}"; do
  name=$(basename "$pic")
  lookup["$name"]="$pic"
printf '%s\0icon\x1f%s\n' "$name" "$pic"done

selected=$(printf '%s\n' "${menu_lines[@]}" \
           | rofi -dmenu -i \
                  -theme "$rofiThemeDIR" \
                  -p "Select Wallpaper:" )

target="${lookup[$selected]:-}"
if [[ -z "$target" ]]; then
  exit 0
fi

if ! swww query &>/dev/null; then
  swww-daemon --format xrgb &
  sleep 1
fi

swww img \
     --transition-fps 60 \
     --transition-type any \
     --transition-duration 1 \
     --transition-bezier .43,1.19,1,.4 \
     "$target"

ln -sf "$target" "$HOME/.config/.current_wallpaper"

if [[ "$( < ~/.config/.current_theme )" == "dark" ]]; then
  ~/.config/sway/scripts/theme.sh -d
else
  ~/.config/sway/scripts/theme.sh -l
fi
