#!/bin/bash

wallDIR="$HOME/Wallpapers"
rofiThemeDIR="$HOME/.config/WallpaperSelector/wallpaper-selector.rasi"

FPS=60
TYPE="any"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS=( --transition-fps "$FPS" \
              --transition-type "$TYPE" \
              --transition-duration "$DURATION" \
              --transition-bezier "$BEZIER" )

mapfile -d '' PICS < <(
  find -L "$wallDIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
    -print0
)

if (( ${#PICS[@]} == 0 )); then
  echo "No wallpapers found in $wallDIR" >&2
  exit 1
fi

RANDOM_IDX=$(( RANDOM % ${#PICS[@]} ))
RANDOM_PIC=${PICS[RANDOM_IDX]}
RANDOM_LABEL="Random: $(basename "$RANDOM_PIC")"

mapfile -d '' SORTED_PICS < <(
  printf '%s\0' "${PICS[@]}" | sort -z
)

menu_lines=()
menu_lines+=("$RANDOM_LABEL"$'\0'"icon"$'\x1f'"$RANDOM_PIC")

for pic in "${SORTED_PICS[@]}"; do
  fname=$(basename "$pic")
  label="${fname%.*}"
  menu_lines+=("$label"$'\0'"icon"$'\x1f'"$pic")
done

selected_label=$(printf '%s\n' "${menu_lines[@]}" \
                  | rofi -dmenu -i \
                         -theme "$rofiThemeDIR" \
                         -p "Select Wallpaper:" \
                         -format 's')  

selected_path=""
if [[ "$selected_label" == "$RANDOM_LABEL" ]]; then
  selected_path="$RANDOM_PIC"
else
  for pic in "${SORTED_PICS[@]}"; do
    if [[ "${selected_label}" == "$(basename "$pic" .${pic##*.})" ]]; then
      selected_path="$pic"
      break
    fi
  done
fi

if [[ -n "$selected_path" ]]; then
  if ! pgrep -x swww-daemon >/dev/null; then
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
fi