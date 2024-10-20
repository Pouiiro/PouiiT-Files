spotify=(
	icon.font="$FONT:Bold:15.0"
	label.font="$FONT:Bold:14.0"
)

sketchybar --add event spotify_change com.spotify.client.PlaybackStateChanged
sketchybar --add item spotify right \
	--set spotify "${spotify[@]}" \
	background.padding_left=$GAP \
	script="$PLUGIN_DIR/spotify.sh" \
	--subscribe spotify spotify_change mouse.clicked
