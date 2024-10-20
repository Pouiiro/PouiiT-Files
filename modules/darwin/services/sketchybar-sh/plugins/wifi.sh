INFO="$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}' | xargs networksetup -getairportnetwork | sed "s/Current Wi-Fi Network: //")"
#
# sketchybar --set wifi \
# 	icon= icon.color=0xff58d1fc \
# 	label="$INFO"

case "$SENDER" in
"mouse.entered")
	sketchybar --set $NAME label="$INFO" label.drawing=on
	;;
"mouse.exited")
	sketchybar --set $NAME label.drawing=off
	;;
*)
	sketchybar --set $NAME icon= label="$INFO" label.drawing=off
	;;
esac
