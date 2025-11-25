#!/usr/bin/env bash

OUTPUT_DIR=$HOME/Pictures/screenshot


with_edit() {
	mkdir -p $OUTPUT_DIR

	grim - | satty --filename - \
		--output-filename "$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
		--early-exit \
		--actions-on-enter save-to-clipboard \
		--copy-command 'wl-copy'
}

with_zone_selection() {
  grim -g "$(slurp)" - | wl-copy
}

case $1 in
  "edit")
    with_edit
    ;;
  "zone")
    with_zone_selection
    ;;

  *)
    with_edit
    ;;
esac
