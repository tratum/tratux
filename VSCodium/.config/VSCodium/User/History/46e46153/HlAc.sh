#!/bin/bash
# Refresh Script for Waybar, Dunst, Rofi, and Wallust

processes=(waybar dunst rofi wallust)
for proc in "${processes[@]}"; do
    if pidof "$proc" > /dev/null; then
        pkill "$proc"
    fi
done

swaymsg reload
sleep 1
#waybar & waybar is already loading when sway is reloaded
dunst &
wallust &

exit 0