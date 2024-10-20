headphones=(
	updates=on
	update_freq=60
	padding_right=10
	icon.font="$FONT:Regular:16.0"
	label.font="$FONT:Bold:15.0"
	script="$PLUGIN_DIR/headphones.sh"
	# click_script="open -a /System/Applications/headphones.app"
)

sketchybar --add item headphones left \
	--set headphones "${headphones[@]}" \
	--subscribe headphones mouse.entered mouse.exited volume
