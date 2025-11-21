#!/usr/bin/env bash

us_layout="us"
intl_layout="eng"

# Function to print output once
print_layout() {
    if [[ "$1" == "$intl_layout" ]]; then
        echo "<span color='#8bd5ca'> </span>"
    else
        echo "  "
    fi
}

# Initial display
layout=$(mmsg -k | awk '{print $3}')
print_layout "$layout"

# Watch for changes
mmsg -w -k | while read -r _ _ new_layout; do
    print_layout "$new_layout"
    # Send signal to Waybar to refresh module
    # kill -SIGRTMIN+5 $(pidof waybar)
done
