#!/bin/bash

wallDIR="$HOME/Wallpapers"
rofiThemeDIR="$HOME/.config/WallpaperSelector/wallpaper-selector.rasi"

# ─── Gather all images ─────────────────────────────────────────────────────────
mapfile -t FULLPATHS < <(
  find -L "$wallDIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \)
)

if (( ${#FULLPATHS[@]} == 0 )); then
  echo "No wallpapers found in $wallDIR" >&2
  exit 1
fi

# ─── Prepare filenames + lookup ────────────────────────────────────────────────
declare -A lookup
LABELS=()

for fp in "${FULLPATHS[@]}"; do
  name=$(basename "$fp")
  lookup["$name"]="$fp"
  LABELS+=("$name")
done

# ─── Add a “Random” choice at the top ─────────────────────────────────────────
RANDOM_FILE="${FULLPATHS[RANDOM % ${#FULLPATHS[@]}]}"
RANDOM_LABEL="Random: $(basename "$RANDOM_FILE")"
lookup["$RANDOM_LABEL"]="$RANDOM_FILE"
LABELS=( "$RANDOM_LABEL" "${LABELS[@]}" )

# ─── Show Rofi menu (just filenames) ──────────────────────────────────────────
selected=$(printf '%s\n' "${LABELS[@]}" \
           | rofi -dmenu -i \
                  -theme "$rofiThemeDIR" \
                  -p "Select Wallpaper:" \
                  -format 's')

# ─── Map back to full path and apply ──────────────────────────────────────────
if [[ -n "${lookup[$selected]:-}" ]]; then
  target="${lookup[$selected]}"

  # Ensure swww-daemon is running
  if ! swww query &>/dev/null; then
    swww-daemon --format xrgb &
    sleep 1
  fi

  # Apply with smooth transition
  swww img \
    --transition-fps 60 \
    --transition-type random \
    --transition-duration 1 \
    --transition-bezier .43,1.19,1,.4 \
    "$target"

  # Update symlink & theme
  ln -sf "$target" "$HOME/.config/.current_wallpaper"
  if [[ "$( < ~/.config/.current_theme )" == "dark" ]]; then
    ~/.config/sway/scripts/theme.sh -d
  else
    ~/.config/sway/scripts/theme.sh -l
  fi
fi
