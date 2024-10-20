#!/usr/bin/env sh

LAPHEADIES="A50 X"
HEADIES="WH-1000XM4"
EARSIES="WH-1000XM4"
ICON="􀑈"

update() {
	DEVICE_LIST="$(SwitchAudioSource -c -t output)"
	DEVICE="$DEVICE_LIST"

	if [ "$DEVICE" != "$HEADIES" ] && [ "$DEVICE_LIST" != "$EARSIES" ] && [ "$DEVICE_LIST" != "$LAPHEADIES" ]; then
		sketchybar --set $NAME icon.drawing=on background.padding_right=1 background.padding_left=4 label.drawing=off icon=􀝎 label="$DEVICE"
		return
	fi

	if [ "$DEVICE" = "$EARSIES" ]; then
		ICON="􀟥"
	fi

	sketchybar --set $NAME icon.drawing=on background.padding_right=1 background.padding_left=4 label="$DEVICE" icon="$ICON" label.drawing=off
}

case "$SENDER" in
"mouse.entered")
	sketchybar --set $NAME label.drawing=on
	;;
"mouse.exited")
	sketchybar --set $NAME label.drawing=off
	;;
*)
	update
	;;
esac
