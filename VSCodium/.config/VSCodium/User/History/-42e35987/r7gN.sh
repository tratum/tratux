#!/usr/bin/env bash

theme="$HOME/.config/PowerMenu/style.rasi"

##lastlogin="$(last $USER | head -n1 | tr -s ' ' | cut -d' ' -f5,6,7)"
uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

hibernate=''
shutdown=''
reboot='↻'
lock='󰌾'
suspend='󰤄'
logout=''
yes='○'
no='✗'

rofi_cmd() {
	rofi -dmenu -p "$USER@$host" -mesg "⏳ Uptime: $uptime" -theme "$theme"
}

confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
	      -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
	      -theme-str 'listview {columns: 2; lines: 1;}' \
	      -theme-str 'element-text {horizontal-align: 0.5;}' \
	      -theme-str 'textbox {horizontal-align: 0.5;}' \
	      -dmenu -p 'Confirmation' -mesg 'Are you Sure?' -theme $theme
}

confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--hibernate' ]]; then
			systemctl hibernate
		elif [[ $1 == '--suspend' ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
			if [[ "$DESKTOP_SESSION" == 'openbox' ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
				i3-msg exit
			elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
				qdbus org.kde.ksmserver /KSMServer logout 0 0 0
			elif [[ "$DESKTOP_SESSION" == 'sway' ]]; then
				swaymsg exit
			fi
		elif [[ $1 == '--lock' ]]; then
			loginctl lock-session && hyprlock
		fi
	else
		exit 0
	fi
}

chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $hibernate)
		run_cmd --hibernate
        ;;
    $lock)
		run_cmd --lock
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
