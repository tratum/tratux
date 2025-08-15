#!/bin/bash

wallDIR="$HOME/Wallpapers"
rofiThemeDIR="$HOME/.config/WallpaperSelector/wallpaper-selector.rasi"

mapfile -t FULLPATHS < <(
  find -L "$wallDIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \)
)

if (( ${#FULLPATHS[@]} == 0 )); then
  echo "No wallpapers found in $wallDIR" >&2
  exit 1
fi

declare -A lookup
LABELS=()

for fp in "${FULLPATHS[@]}"; do
  name=$(basename "$fp")
  lookup["$name"]="$fp"
  LABELS+=("$name")
done

RANDOM_FILE="${FULLPATHS[RANDOM % ${#FULLPATHS[@]}]}"
RANDOM_LABEL="$(basename "$RANDOM_FILE")"
lookup["$RANDOM_LABEL"]="$RANDOM_FILE"
LABELS=( "$RANDOM_LABEL" "${LABELS[@]}" )

selected=$(printf '%s\n' "${LABELS[@]}" \
           | rofi -dmenu -i \
                  -theme "$rofiThemeDIR" \
                  -p "Select Wallpaper:" \
                  -format 's')

if [[ -n "${lookup[$selected]:-}" ]]; then
  target="${lookup[$selected]}"

  if ! swww query &>/dev/null; then
    swww-daemon --format xrgb &
    sleep 1
  fi

  swww img \
    --transition-fps 60 \
    --transition-type random \
    --transition-duration 1 \
    --transition-bezier .43,1.19,1,.4 \
    "$target"
  ln -sf "$target" "$HOME/.config/.current_wallpaper"
  if [[ "$( < ~/.config/.current_theme )" == "dark" ]]; then
    ~/.config/sway/scripts/theme.sh -d
  else
    ~/.config/sway/scripts/theme.sh -l
  fi
fi
