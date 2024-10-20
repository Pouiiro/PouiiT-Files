brew=(
	"${notification_defaults[@]}"
	icon=
	padding_right=10
	script="$PLUGIN_DIR/brew.sh"
	click_script="open -a /System/Applications/Messages.app"
)

sketchybar --add item brew right \
	--set brew "${brew[@]}" \
	--subscribe messages front_app_switched system_woke
