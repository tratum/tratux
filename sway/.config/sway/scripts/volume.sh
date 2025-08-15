#!/bin/bash

# Get default sink (output device)
get_default_sink() {
    pactl get-default-sink
}

# Get default source (input/microphone)
get_default_source() {
    pactl get-default-source
}

# Increase Volume by 1%
inc_volume() {
    pactl set-sink-volume "$(get_default_sink)" +1%
}

# Decrease Volume by 1%
dec_volume() {
    pactl set-sink-volume "$(get_default_sink)" -1%
}

# Toggle Mute for Output
toggle_mute() {
    pactl set-sink-mute "$(get_default_sink)" toggle
}

# Increase Microphone Volume by 1%
inc_mic_volume() {
    pactl set-source-volume "$(get_default_source)" +1%
}

# Decrease Microphone Volume by 1%
dec_mic_volume() {
    pactl set-source-volume "$(get_default_source)" -1%
}

# Toggle Mute for Microphone
toggle_mic() {
    pactl set-source-mute "$(get_default_source)" toggle
}

# Command handler
case "$1" in
    --inc)
        inc_volume
        ;;
    --dec)
        dec_volume
        ;;
    --toggle)
        toggle_mute
        ;;
    --mic-inc)
        inc_mic_volume
        ;;
    --mic-dec)
        dec_mic_volume
        ;;
    --toggle-mic)
        toggle_mic
        ;;
    *)
        echo "Usage: $0 [--inc|--dec|--toggle|--mic-inc|--mic-dec|--toggle-mic]"
        ;;
esac
