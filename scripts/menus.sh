#!/usr/bin/env bash

rosewater="#f5e0dc"
flamingo="#f2cdcd"
pink="#f5c2e7"
mauve="#cba6f7"
red="#f38ba8"
maroon="#eba0ac"
peach="#fab387"
yellow="#f9e2af"
green="#a6e3a1"
teal="#94e2d5"
sky="#89dceb"
sapphire="#74c7ec"
blue="#89b4fa"
lavender="#b4befe"
text="#cdd6f4"
subtext1="#bac2de"
subtext0="#a6adc8"
overlay2="#9399b2"
overlay1="#7f849c"
overlay0="#6c7086"
surface2="#585b70"
surface1="#45475a"
surface0="#313244"
base="#1e1e2e"
mantle="#181825"
crust="#11111b"

font="JetBrainsMono Nerd Font:size=15" 

# default options
# usage: dmenu "${dmenu_options[@]}"
# override: dmenu "${dmenu_options[@]}" -nb "#FFFFFF"
# note: -h require line-height patch
dmenu_options=(
    -fn "$font"
    -nb "$base"
    -nf "$text"
    -sb "$lavender"
    -sf "$base"
    -p "󰣇 "
    -h 43
    -i
)


# require dmenu patch with line-height (and fuzzy find optional)
run_menu() {
	dmenu_run "${dmenu_options[@]}"
}

kill_menu() {
	process=$(ps -e --format comm -u $USER | grep -vE 'systemd|init|kthreadd|rcu_sched' | sort | uniq | dmenu "${dmenu_options[@]}" -sb $red -p "󰚌 ")

	# Verify that a process was selected before attempting to kill it
	if [ -n "$process" ]; then
		# Confirmation prompt before killing the selected process
		response=$(echo -e "cancel\nterm\nkill" | dmenu "${dmenu_options[@]}" -sb $red -p "Signal $process?" )

		if [ "$response" = "term" ]; then
			pkill -15 "$process"
		elif [ "$response" = "kill" ]; then
			pkill -9 "$process"
		fi
	fi
}

clipboard_manager() {
    cliphist list | 
        awk -F $'\t' '{print $2 " :: " $1}' |
        dmenu "${dmenu_options[@]}" -sb $green -l 10 -i |
        awk -F ' :: ' '{print $2}' |
        xargs -I{} cliphist decode {} |
        wl-copy
}

start_menu() {
    LOCK=" lock"
    EXIT=" exit"
    REBOOT=" reboot"
    SHUTDOWN=" shutdown"

    option=$(echo -e "$LOCK\n$EXIT\n$REBOOT\n$SHUTDOWN" | dmenu "${dmenu_options[@]}" -sb $peach -p " ")

    # Handle selection
    case $option in
        "$LOCK")
            hyprlock
            ;;
        "$EXIT")
            # quit mango
            mmsg -q
            ;;
        "$REBOOT")
            systemctl reboot
            ;;
        "$SHUTDOWN")
            systemctl poweroff -i
            ;;
    esac
}

case $1 in
  "run")
    run_menu
    ;;

  "kill")
    kill_menu
    ;;

  "start")
    start_menu
    ;;

  "clip")
    clipboard_manager
    ;;

  *)
    run_menu
    ;;
esac
