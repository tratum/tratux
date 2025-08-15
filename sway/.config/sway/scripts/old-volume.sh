#!/bin/bash

# Increase Volume by 1%
inc_volume() {
    pamixer -i 1 --allow-boost --set-limit 150
}

# Decrease Volume by 1%
dec_volume() {
    pamixer -d 1
}

# Toggle Mute for Output
toggle_mute() {
    if [ "$(pamixer --get-mute)" = "false" ]; then
        pamixer -m
    else
        pamixer -u
    fi
}

# Increase Microphone Volume by 1%
inc_mic_volume() {
    pamixer --default-source -i 1
}

# Decrease Microphone Volume by 1%
dec_mic_volume() {
    pamixer --default-source -d 1
}

# Toggle Mute for Microphone
toggle_mic() {
    if [ "$(pamixer --default-source --get-mute)" = "false" ]; then
        pamixer --default-source -m
    else
        pamixer --default-source -u
    fi
}

if [[ "$1" == "--inc" ]]; then
    inc_volume
elif [[ "$1" == "--dec" ]]; then
    dec_volume
elif [[ "$1" == "--toggle" ]]; then
    toggle_mute
elif [[ "$1" == "--mic-inc" ]]; then
    inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
    dec_mic_volume
elif [[ "$1" == "--toggle-mic" ]]; then
    toggle_mic
else
    echo "Usage: $0 [--inc|--dec|--toggle|--mic-inc|--mic-dec|--toggle-mic]"
fi