#!/bin/bash
echo "CliphistDisplay.sh triggered at $(date)" >> /tmp/cliphist_debug.log

# Retrieve clipboard history (one entry per line)
history=$(cliphist list)

# Exit if there’s no history available
if [ -z "$history" ]; then
    echo "No clipboard history available." >> /tmp/cliphist_debug.log
    exit 0
fi

# Use wofi (with your custom Cliphist config and style) to display the history and enable search.
selected=$(echo "$history" | wofi --dmenu \
    --prompt "Clipboard History" \
    --width 60% --height 80% \
    --config ~/.config/wofi/Cliphist/config \
    --style ~/.config/wofi/Cliphist/style.css)

# If no entry was selected, exit.
[ -z "$selected" ] && exit 0

# Next, ask what action you want to take.
# (Since wofi doesn’t support custom keybindings like rofi, we offer a simple action menu.)
action=$(printf "Paste\nDelete\nWipe All\nCancel" | wofi --dmenu \
    --prompt "Action for selection:" \
    --width 30% --height 40% \
    --config ~/.config/wofi/Cliphist/config \
    --style ~/.config/wofi/Cliphist/style.css)

case "$action" in
    "Paste")
        # Decode the selected entry and copy it to the clipboard.
        cliphist decode <<<"$selected" | wl-copy
        ;;
    "Delete")
        # Delete the selected entry.
        cliphist delete <<<"$selected"
        ;;
    "Wipe All")
        # Wipe all clipboard history.
        cliphist wipe
        ;;
    *)
        # Cancel or any unrecognized action.
        ;;
esac
