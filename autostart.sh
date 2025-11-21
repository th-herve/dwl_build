#!/usr/bin/env bash

wlr-randr --output DP-3 --mode 2560x1440@240.001007 >/dev/null 2>&1 &

swaybg --image ~/Pictures/wallpaper/spacehawks.png  >/dev/null 2>&1 &

waybar -c ~/.config/dwl/bar/config.jsonc -s ~/.config/dwl/bar/style.css >/dev/null 2>&1 &

mako >/dev/null 2>&1 &

spotify-launcher >/dev/null 2>&1 &

zen-browser >/dev/null 2>&1 &

# keep clipboard content when closing an app
wl-clip-persist --clipboard regular --reconnect-tries 0 &

# clipboard content manager
wl-paste --type text --watch cliphist store & 
wl-paste --type image --watch cliphist store &

~/.config/mango/script/spotify-notify.sh >/dev/null 2>&1 &

