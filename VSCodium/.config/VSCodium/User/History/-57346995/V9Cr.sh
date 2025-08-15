#!/bin/bash

keybindings=$(cat <<'EOF'
ESC                       | close this app
   enter                 | Terminal (Alacritty)
   D                     | App Launcher (rofi-wayland)
   T                     | Open File Manager (Thunar)
   Q                     | Kill active window
   W                     | Choose wallpaper (Wallpaper Menu)
   C                     | Fullscreen (Toggles to full screen)
   F                     | Fullscreen (Toggles to full screen)
   Alt V                 | Clipboard Menu (cliphist)
   SHIFT W               | Reload Waybar
   SHIFT S               | Screenshot Menu
CTRL ALT L                | screen lock (hyprlock)
CTRL ALT Del              | Power Menu
   ←↑→↓                  | Change Focus Window (Workspace)
   [0-9]                 | Change Workspace (Workspace)
   CTRL ←→↑↓             | Resize focused window (Workspace)
   SHIFT [0-9]           | Move focused window to a relative workspace (follow) (Workspace)
EOF
)

echo -e "$keybindings" | column -s '|' -t | wofi --dmenu \
    --prompt "Key Bindings" \
    --width 70% --height 70% \
    --config ~/.config/wofi/KeyHints/config \
    --style ~/.config/wofi/KeyHints/style.css
