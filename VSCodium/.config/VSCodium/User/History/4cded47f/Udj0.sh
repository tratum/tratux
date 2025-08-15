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
  entries+=("$name"$'\0'"icon"$'\x1f'"$pic")
done

selected_name=$(printf '%s\n' "${entries[@]}" \
  | rofi -dmenu -i -theme "$rofiThemeDIR" -p "Select Wallpaper:" -format 's')

[[ -n "$selected_name" ]] || exit 0

selected_path="${lookup["$selected_name"]}"

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
