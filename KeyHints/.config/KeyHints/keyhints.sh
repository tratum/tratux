#!/bin/bash

keybindings=$(cat <<'EOF'
ESC             | close this app
   enter       | Terminal (Alacritty)
   D           | App Launcher (rofi-wayland)
   T           | Open File Manager (Thunar)
   Q           | Kill active window
   Alt V       | Clipboard Menu (cliphist)
   W           | Choose wallpaper (Wallpaper Menu)
   SHIFT W     | Reload Waybar
   SHIFT S     | Screenshot Menu
CTRL ALT L      | screen lock (hyprlock)
CTRL ALT Del    | Power Menu
   F           | Fullscreen (Toggles to full screen)
   ←↑→↓       | Change Focus Window (Workspace)
   [0-9]      | Change Workspace (Workspace)
   CTRL ←→↑↓   | Resize focused window (Workspace)
   SHIFT [0-9] | Move focused window to a relative workspace (follow) (Workspace)
EOF
)

formatted=$(echo -e "$keybindings" | column -s '|' -t)
echo -e "$formatted" | rofi -dmenu -p "Key Bindings" -theme ~/.config/KeyHints/keyhint.rasi
