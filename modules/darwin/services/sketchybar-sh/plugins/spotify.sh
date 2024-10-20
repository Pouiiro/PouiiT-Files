DEFAULT_NAME="spotify"

PLAYING_COLOR=0xffa6da95
PAUSED_COLOR=0xffffa217

MAIN_PLAYING_ICON=󱑽
MAIN_PAUSED_ICON=󰐎

PLAYER_PLAYING_ICON=󰏤
PLAYER_PAUSED_ICON=

# Max number of characters so it fits nicely to the right of the notch
# MAY NOT WORK WITH NON-ENGLISH CHARACTERS

MAX_LENGTH=33

# Logic starts here, do not modify

HALF_LENGTH=$(((MAX_LENGTH + 1) / 2))

update_playpause_icon() {
	case "$PLAYER_STATE" in
	"playing" | "Playing")
		ICON=$PLAYER_PLAYING_ICON
		;;
	*)
		ICON=$PLAYER_PAUSED_ICON
		;;
	esac

	sketchybar --set "$DEFAULT_NAME.playpause" icon=$ICON
}

update_track() {
	# Spotify JSON / $INFO comes in malformed, line below sanitizes it
	SPOTIFY_JSON="$INFO"

	if [[ ! -z $SPOTIFY_JSON ]]; then
		PLAYER_STATE=$(echo "$SPOTIFY_JSON" | jq -r '.["Player State"]')
		update_playpause_icon

		if [ $PLAYER_STATE = "Playing" ]; then
			TRACK="$(echo "$SPOTIFY_JSON" | jq -r .Name)"
			ARTIST="$(echo "$SPOTIFY_JSON" | jq -r .Artist)"

			# Calculations so it fits nicely
			TRACK_LENGTH=${#TRACK}
			ARTIST_LENGTH=${#ARTIST}

			if [ $((TRACK_LENGTH + ARTIST_LENGTH)) -gt $MAX_LENGTH ]; then
				# If the total length exceeds the max
				if [ $TRACK_LENGTH -gt $HALF_LENGTH ] && [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
					# If both the track and artist are too long, cut both at half length - 1

					# If MAX_LENGTH is odd, HALF_LENGTH is calculated with an extra space, so give it an extra char
					TRACK="${TRACK:0:$((MAX_LENGTH % 2 == 0 ? HALF_LENGTH - 2 : HALF_LENGTH - 1))}…"
					ARTIST="${ARTIST:0:$((HALF_LENGTH - 2))}…"

				elif [ $TRACK_LENGTH -gt $HALF_LENGTH ]; then
					# Else if only the track is too long, cut it by the difference of the max length and artist length
					TRACK="${TRACK:0:$((MAX_LENGTH - ARTIST_LENGTH - 1))}…"
				elif [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
					ARTIST="${ARTIST:0:$((MAX_LENGTH - TRACK_LENGTH - 1))}…"
				fi
			fi

			sketchybar --set $NAME \
				label="${ARTIST} - ${TRACK}" \
				icon=$MAIN_PLAYING_ICON icon.color=$PLAYING_COLOR
		else
			sketchybar --set $NAME \
				label="$PLAYER_STATE" \
				icon=$MAIN_PAUSED_ICON icon.color=$PAUSED_COLOR
		fi
	else
		sketchybar --set $NAME \
			label="Unknown" \
			icon=$MAIN_PAUSED_ICON icon.color=$PAUSED_COLOR
	fi
}

mouse_clicked() {
	case "$NAME" in
	"$DEFAULT_NAME")
		open -a Spotify
		;;
	"$DEFAULT_NAME.next")
		osascript -e 'tell application "Spotify" to play next track'
		;;
	"$DEFAULT_NAME.playpause")
		osascript -e 'tell application "Spotify" to playpause'

		PLAYER_STATE=$(osascript -e 'tell application "Spotify" to player state')
		update_playpause_icon
		;;
	"$DEFAULT_NAME.back")
		osascript -e 'tell application "Spotify" to play previous track'
		;;
	esac
}

case "$SENDER" in
"mouse.clicked")
	mouse_clicked
	;;
*)
	if [[ "$NAME" = "$DEFAULT_NAME" ]]; then
		update_track
	fi
	;;
esac
