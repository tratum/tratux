# Theme Selection
# Currently You can only choose from 2 Themes
selectedTheme="2"

# Import Current Theme
theme="$HOME/.config/Screenshots/themes/theme$selectedTheme.rasi"

# Theme Elements
prompt='Screenshot'
mesg="Save Directory: $(xdg-user-dir PICTURES)/Screenshots"

if [[ "$selectedTheme" == "1" ]]; then
	list_col='1'
	list_row='5'
	win_width='580px'
elif [[ "$selectedTheme" == "2" ]]; then
	list_col='5'
	list_row='1'
	win_width='720px'
fi

# Options (Icon or text based on theme)
layout=$(grep 'USE_ICON' "${theme}" | cut -d'=' -f2)
if [[ "$layout" == 'NO' ]]; then
	option_1="▣  Capture Desktop"
	option_2="✂  Capture Area"
	option_3="⛶  Capture Window"
	option_4="⏱  Capture in 5s"
	option_5="⏱  Capture in 10s"
else
	option_1="▣"
	option_2="✂"
	option_3="⛶"
	option_4="⏱"
	option_5="⏱"
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "${theme}"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Filename creation
time_stamp=$(date +%Y-%m-%d-%H-%M-%S)
# For full screenshot geometry we use swaymsg via wlr-randr if needed
geometry=$(wlr-randr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current')
dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_${time_stamp}_${geometry}.png"

[ ! -d "$dir" ] && mkdir -p "$dir"

# Notify and view screenshot (using dunstify and viewnior)
notify_view() {
	notify_cmd_shot='dunstify -u low --replace=699'
	$notify_cmd_shot "Copied to clipboard."
	viewnior "${dir}/$file"
	if [[ -e "$dir/$file" ]]; then
		$notify_cmd_shot "Screenshot Saved."
	else
		$notify_cmd_shot "Screenshot Deleted."
	fi
}

# Copy screenshot to clipboard using wl-copy
copy_shot () {
	# Write image to file and pipe the same image to wl-copy
	tee "$file" | wl-copy -t image/png
}

# Countdown function
countdown () {
	for sec in $(seq $1 -1 1); do
		dunstify -t 1000 --replace=699 "Taking shot in: $sec"
		sleep 1
	done
}

# Helper: Get active window geometry using swaymsg and jq
active_geometry() {
	swaymsg -t get_tree | jq -r 'recurse(.nodes[], .floating_nodes[]) | select(.focused==true) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)"'
}

# Take screenshot functions using grim and slurp:
shotnow () {
	cd "$dir" && sleep 0.5 && grim -t png - | copy_shot
	notify_view
}

shot5 () {
	countdown 5
	sleep 1 && cd "$dir" && grim -t png - | copy_shot
	notify_view
}

shot10 () {
	countdown 10
	sleep 1 && cd "$dir" && grim -t png - | copy_shot
	notify_view
}

shotwin () {
	# Capture active window using geometry from swaymsg
	geom=$(active_geometry)
	cd "$dir" && grim -g "$geom" -t png - | copy_shot
	notify_view
}

shotarea () {
	# Let the user select an area using slurp
	cd "$dir" && grim -g "$(slurp)" -t png - | copy_shot
	notify_view
}

# Execute Command based on option chosen
run_cmd() {
	case "$1" in
		--opt1) shotnow ;;
		--opt2) shotarea ;;
		--opt3) shotwin ;;
		--opt4) shot5 ;;
		--opt5) shot10 ;;
	esac
}

# Rofi selection and action dispatch
chosen="$(run_rofi)"
case ${chosen} in
    "$option_1")
		run_cmd --opt1
        ;;
    "$option_2")
		run_cmd --opt2
        ;;
    "$option_3")
		run_cmd --opt3
        ;;
    "$option_4")
		run_cmd --opt4
        ;;
    "$option_5")
		run_cmd --opt5
        ;;
esac
