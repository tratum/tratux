#!/bin/bash

wallDIR="$HOME/Wallpapers"
rofiThemeDIR="$HOME/.config/WallpaperSelector/wallpaper-selector.rasi"

FPS=60
TYPE="any"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS=(
  --transition-fps "$FPS"
  --transition-type "$TYPE"
  --transition-duration "$DURATION"
  --transition-bezier "$BEZIER"
)

mapfile -d '' ALL_PICS < <(
  find -L "$wallDIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
    -print0
)

if (( ${#ALL_PICS[@]} == 0 )); then
  echo "No wallpapers found in $wallDIR" >&2
  exit 1
fi

mapfile -t SHUFFLED_PICS < <(
  printf '%s\n' "${ALL_PICS[@]}" | shuf
)

declare -A lookup
menu_lines=()

for pic in "${SHUFFLED_PICS[@]}"; do
  name=$(basename "$pic")
  lookup["$name"]="$pic"
  menu_lines+=("$name"$'\0'"icon"$'\x1f'"$pic")
done

selected=$(printf '%s\n' "${menu_lines[@]}" \
           | rofi -dmenu -i \
                  -theme "$rofiThemeDIR" \
                  -p "Select Wallpaper:" \
                  -format 's')

target="${lookup[$selected]:-}"
if [[ -n "$target" ]]; then
  if ! swww query &>/dev/null; then
    swww-daemon --format xrgb &
    sleep 1
  fi

  swww img "${SWWW_PARAMS[@]}" "$target"

  ln -sf "$target" "$HOME/.config/.current_wallpaper"

  if [[ "$( < ~/.config/.current_theme )" == "dark" ]]; then
    ~/.config/sway/scripts/theme.sh -d
  else
    ~/.config/sway/scripts/theme.sh -l
  fi
fi