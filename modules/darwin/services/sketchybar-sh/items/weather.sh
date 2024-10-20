weather=(
	updates=on
	padding_right=10
	update_freq=60
	icon.font="$FONT:Regular:16.0"
	label.font="$FONT:Bold:15.0"
	script="$PLUGIN_DIR/weather.sh"
)

sketchybar --add item weather left \
	--set weather "${weather[@]}" \
	--subscribe weather mouse.entered mouse.exited
