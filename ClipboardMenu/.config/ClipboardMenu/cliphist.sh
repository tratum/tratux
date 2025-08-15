#!/bin/bash
# Clipboard Manager. This script uses cliphist, rofi, and wl-copy.

# Variables
rofi_theme="$HOME/.config/ClipboardMenu/clipboard.rasi"
msg='👀 **Note**  CTRL DEL = cliphist del (entry)   or   ALT DEL - cliphist wipe (all)'
# Actions:
# CTRL Del to delete an entry
# ALT Del to wipe clipboard contents

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

while true; do
  result=$(
      rofi -i -dmenu \
          -kb-custom-1 "Control-Delete" \
          -kb-custom-2 "Alt-Delete" \
          -config "$rofi_theme" \
          -p "" \
          --separator-style none \
          -mesg "$msg" < <(cliphist list)
  )

    case "$?" in
        1)
            exit
            ;;
        0)
            case "$result" in
                "")
                    continue
                    ;;
                *)
                    cliphist decode <<<"$result" | wl-copy
                    exit
                    ;;
            esac
            ;;
        10)
            cliphist delete <<<"$result"
            ;;
        11)
            cliphist wipe
            ;;
    esac
done

