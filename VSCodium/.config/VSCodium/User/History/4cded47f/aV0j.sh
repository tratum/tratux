#

wallDIR="$HOME/Wallpapers"
rofiThemeDIR="$HOME/.config/WallpaperSelector/wallpaper-selector.rasi"

# 1) Gather only top-level images:
mapfile -d '' ALL_PICS < <(
  find -L "$wallDIR" -maxdepth 1 -mindepth 1 \
       -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
       -print0
)
(( ${#ALL_PICS[@]} )) || {
  echo "No wallpapers found in $wallDIR" >&2
  exit 1
}

# 2) Shuffle for randomness
mapfile -t SHUFFLED_PICS < <(
  printf '%s\n' "${ALL_PICS[@]}" | shuf
)

# 3) Build lookup + menu lines (basename + icon token)
declare -A lookup
menu_lines=()
for full in "${SHUFFLED_PICS[@]}"; do
  name=$(basename "$full")
  lookup["$name"]="$full"
  menu_lines+=("$name"$'\0'"icon"$'\x1f'"$full")
done

# 4) Launch Rofi and get the chosen basename
selected=$(printf '%s\n' "${menu_lines[@]}" \
           | rofi -dmenu -i \
                  -theme "$rofiThemeDIR" \
                  -p "Select Wallpaper:" )

# 5) Map back to full path, bail if nothing chosen
target="${lookup[$selected]:-}"
if [[ -z "$target" ]]; then
  exit 0
fi

# 6) Ensure the swww daemon is running
if ! swww query &>/dev/null; then
  swww-daemon --format xrgb &
  sleep 1
fi

# 7) Actually set the wallpaper
swww img \
     --transition-fps 60 \
     --transition-type any \
     --transition-duration 1 \
     --transition-bezier .43,1.19,1,.4 \
     "$target"

# 8) Update “current” symlink & reapply your theme
ln -sf "$target" "$HOME/.config/.current_wallpaper"

if [[ "$( < ~/.config/.current_theme )" == "dark" ]]; then
  ~/.config/sway/scripts/theme.sh -d
else
  ~/.config/sway/scripts/theme.sh -l
fi
