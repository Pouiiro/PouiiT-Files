#!/bin/bash

diskmonitor=(
	icon.font="$FONT:Bold:19"
	icon.padding_right=0
	label.drawing=off
	y_offset=1
	update_freq=300
	updates=when_shown
	script="$PLUGIN_DIR/diskmonitor.sh"
)

misc=(
	icon.drawing=off
	width=0
	padding_right=4
	update_freq=300
	updates=when_shown
	label.drawing=off
)

diskmonitor_label=(
	"${misc[@]}"
	label.font="$FONT:Bold:12"
	y_offset=6
)

diskmonitor_value=(
	"${misc[@]}"
	label.font="$FONT:Bold:12"
	y_offset=-4
)

sketchybar \
	--add item diskmonitor.label right --set diskmonitor.label "${diskmonitor_label[@]}" \
	\
	--add item diskmonitor.value right --set diskmonitor.value "${diskmonitor_value[@]}" \
	\
	--add item diskmonitor right --set diskmonitor "${diskmonitor[@]}" \
	--subscribe diskmonitor mouse.clicked
