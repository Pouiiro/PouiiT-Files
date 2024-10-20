wifi=(
	icon.font="$FONT:Bold:15.0"
	label.font="$FONT:Bold:14.0"
)

sketchybar --add item wifi right \
	--set wifi "${wifi[@]}" \
	script="$PLUGIN_DIR/wifi.sh" \
	--subscribe wifi wifi_change system_woke mouse.entered mouse.exited
