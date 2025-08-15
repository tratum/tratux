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
entries=()
for pic in "${SHUFFLED_PICS[@]}"; do
  name=$(basename "$pic")
  lookup["$name"]="$pic"
  entries+=("$name" "$pic")
done

selected_name=$(printf '%s\x00icon\x1f%s\n' "${entries[@]}" \
  | rofi -dmenu -i -theme "$rofiThemeDIR" -p "Select Wallpaper:" -format 's')

[[ -n "$selected_name" ]] || exit 0

selected_path="${lookup["$selected_name"]}"

if [ -n "$selected_path" ]; then
  if ! pgrep -x "swww-daemon" >/dev/null; then
    swww-daemon --format xrgb &
    sleep 1  
  fi
  swww img \
     --transition-fps 60 \
     --transition-type grow \
     --transition-duration 2 \
     --transition-pos top-left \
     "$selected_path"
  
  ln -sf "$selected_path" "$HOME/.config/.current_wallpaper"
  if [[ "$( < ~/.config/.current_theme )" == "dark" ]]; then
    ~/.config/sway/scripts/theme.sh -d
  else
    ~/.config/sway/scripts/theme.sh -l
  fi
fi
