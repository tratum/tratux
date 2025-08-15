#!/bin/bash

# Variables
THEME_DIR="$HOME/.config/.current_theme"
SCRIPTS_DIR="$HOME/.config/sway/scripts"
SWAY_CONFIG="$HOME/.config/sway/config"
CURR_WALL="$HOME/.config/.current_wallpaper"
WAYBAR_STYLE="$HOME/.config/waybar/style.css"
WAYBAR_DARK="$HOME/.config/waybar/styles/dark.css"
WAYBAR_LIGHT="$HOME/.config/waybar/styles/light.css"

theme_tracker() {
  case "$1" in
    d) echo "dark" > "$THEME_DIR" ;;
    l) echo "light" > "$THEME_DIR" ;;
  esac
}

update_waybar() {
  case "$1" in
    d) cp "$WAYBAR_DARK" "$WAYBAR_STYLE" ;;
    l) cp "$WAYBAR_LIGHT" "$WAYBAR_STYLE" ;;
  esac
}

update_gtk_theming() {
  GTK3_CONFIG="$HOME/.config/gtk-3.0/"
  GTK4_CONFIG="$HOME/.config/gtk-4.0/"

  mkdir -p "$GTK3_CONFIG" "$GTK4_CONFIG"

  case "$1" in
    d)
      cp -rf "$HOME/.themes/Graphite-Dark/gtk-3.0/"* "$GTK3_CONFIG"
      cp -rf "$HOME/.themes/Graphite-Dark/gtk-4.0/"* "$GTK4_CONFIG"
      sed -i "27 c gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Dark'" "$HOME/.config/sway/config"
      sed -i "28 c gsettings set org.gnome.desktop.interface icon-theme 'Win10Sur-dark'" "$HOME/.config/sway/config"
      sed -i "29 c gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'" "$HOME/.config/sway/config"
      cat > "$GTK3_CONFIG/settings.ini" <<EOL
[Settings]
gtk-theme-name=Graphite-Dark
gtk-icon-theme-name=Win10Sur-dark
gtk-cursor-theme-name=Bibata-Modern-Ice
gtk-font-name=Afacad Flux Medium 20
gtk-application-prefer-dark-theme=true
EOL
      ;;
    l)
      cp -rf "$HOME/.themes/Graphite-Light/gtk-3.0/"* "$GTK3_CONFIG/"
      cp -rf "$HOME/.themes/Graphite-Light/gtk-4.0/"* "$GTK4_CONFIG/"
      sed -i "27 c gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Light'" "$HOME/.config/sway/config"
      sed -i "28 c gsettings set org.gnome.desktop.interface icon-theme 'Win10Sur'" "$HOME/.config/sway/config"
      sed -i "29 c gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'" "$HOME/.config/sway/config"
      cat > "$GTK3_CONFIG/settings.ini" <<EOL
[Settings]
gtk-theme-name=Graphite-Light
gtk-icon-theme-name=Win10Sur
gtk-cursor-theme-name=Bibata-Modern-Ice
gtk-font-name=Afacad Flux Medium 20
gtk-application-prefer-dark-theme=false
EOL
      ;;
    *)
      ;;
  esac
}


pallet_generator() {
  case "$1" in
    d) wallust run "$CURR_WALL" --palette dark16 ;;
    l) wallust run "$CURR_WALL" --palette light16 ;;
  esac
}

send_notification() {
  dunstify -u low -i preferences-desktop-theme "$1 Mode"
}

system_reload() {
  sleep 1
  for pid in waybar rofi swaync ags swaybg; do
    killall "$pid" 2>/dev/null
  done  
  sleep 1
  "$SCRIPTS_DIR/refresh.sh"
  sleep 0.5
  current=$(cat "$THEME_DIR")
  case "$current" in
    dark) send_notification "Dark" ;;
    light) send_notification "Light" ;;
  esac
  
  exit 0
}

# Process the command-line options (-d for dark, -l for light)
while getopts "dl" opt; do
  update_waybar "$opt"
  pallet_generator "$opt"
  update_gtk_theming "$opt"
  theme_tracker "$opt"
done

system_reload