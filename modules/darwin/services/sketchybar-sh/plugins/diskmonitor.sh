#!/bin/bash
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

update() {
    # Extract volume data
    VOLUMEDATA=$(df -H /System/Volumes/Data)

    # Debug: Check if VOLUMEDATA is empty
    if [[ -z "$VOLUMEDATA" ]]; then
        echo "Error: Volume data is empty" >> /tmp/sketchybar_debug.log
        return
    fi

    # Debug: Print the volume data
    echo "Volume Data: $VOLUMEDATA" >> /tmp/sketchybar_debug.log

    # Extract disk space values
    USEDSPACE=$(echo "$VOLUMEDATA" | awk 'NR==2 {print $3}' | sed 's/G//')
    TOTALSPACE=$(echo "$VOLUMEDATA" | awk 'NR==2 {print $2}' | sed 's/G//')
    FREESPACE=$(echo "$VOLUMEDATA" | awk 'NR==2 {print $4}' | sed 's/G//')
    
    # Extract the used space percentage directly from df output
    USEDSPACEPERCENT=$(echo "$VOLUMEDATA" | awk 'NR==2 {print $5}' | sed 's/%//')

    # Debug: Print extracted values
    echo "Used Space: $USEDSPACE" >> /tmp/sketchybar_debug.log
    echo "Total Space: $TOTALSPACE" >> /tmp/sketchybar_debug.log
    echo "Free Space: $FREESPACE" >> /tmp/sketchybar_debug.log
    echo "Used Space Percentage: $USEDSPACEPERCENT" >> /tmp/sketchybar_debug.log

    # Determine icon and color based on percentage
    case ${USEDSPACEPERCENT} in
        9[8-9] | 100)
            ICON="󰪥"
            COLOR=$RED
            ;;
        8[8-9] | 9[0-7])
            ICON="󰪤"
            COLOR=$RED
            ;;
        7[6-9] | 8[0-7])
            ICON="󰪣"
            COLOR=$RED
            ;;
        6[4-9] | 7[0-5])
            ICON="󰪢"
            COLOR=$ORANGE
            ;;
        5[2-9] | 6[0-3])
            ICON="󰪡"
            COLOR=$ORANGE
            ;;
        4[0-9] | 5[0-1])
            ICON="󰪠"
            COLOR=$YELLOW
            ;;
        2[8-9] | 3[0-9])
            ICON="󰪟"
            COLOR=$YELLOW
            ;;
        1[6-9] | 2[0-7])
            ICON="󰪞"
            COLOR=$GREEN
            ;;
        [0-9] | 1[0-5])
            ICON="󰝦"
            COLOR=$GREEN
            ;;
        *)
            ICON="󰅚"
            COLOR=$RED
            ;;
    esac

    # Update SketchyBar with the used space percentage
    sketchybar --set $NAME icon=$ICON icon.color=$COLOR
    sketchybar --set $NAME.value label="$USEDSPACEPERCENT%"
}

label_toggle() {
    update

    DRAWING_STATE=$(sketchybar --query $NAME.value | jq -r '.label.drawing')

    if [[ $DRAWING_STATE == "on" ]]; then
        DRAWING="off"
        PADDING="0"
    else
        DRAWING="on"
        PADDING="45"
    fi

    # Display free space in GB on click
    sketchybar --set $NAME.value label.drawing=$DRAWING \
        --set $NAME.label label="$FREESPACE GB" label.drawing=$DRAWING \
        --set $NAME icon.padding_right=$PADDING
}

case "$SENDER" in
"routine" | "forced")
    update
    ;;
"mouse.clicked")
    label_toggle
    ;;
esac
