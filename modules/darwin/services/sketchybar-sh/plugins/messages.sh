#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

# NEWMESSAGES=$(sqlite3 ~/Library/Messages/chat.db "SELECT text FROM message WHERE is_read=0 AND is_from_me=0 AND text!='' AND date_read=0" | wc -l | awk '{$1=$1};1')
COUNT=$(sqlite3 ~/Library/Messages/chat.db "SELECT COUNT(guid) FROM message WHERE NOT(is_read) AND NOT(is_from_me) AND text !=''")

if [ "$COUNT" = 0 ]; then
	return
	# sketchybar --set "$NAME" icon.color="$WHITE" label="$COUNT"
else
	sketchybar --set "$NAME" icon.color="$GREEN" label="$COUNT" icon=􀌤
fi
