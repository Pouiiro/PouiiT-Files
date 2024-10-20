messages=(
	"${notification_defaults[@]}"
	updates=on
	update_freq=30
	padding_right=10
	script="$PLUGIN_DIR/messages.sh"
	click_script="open -a /System/Applications/Messages.app"
)

# sketchybar --add item messages right \
# 	--set messages "${messages[@]}" \
# 	--subscribe messages front_app_switched system_woke
