{
  lib,
  pkgs,
  ...
}: {
  home-manager.users."johnDoe".home.file = {
    ".config/sketchybar/colors.sh".source = "${./sketchybar-sh/colors.sh}";
    ".config/sketchybar/icons.sh".source = "${./sketchybar-sh/icons.sh}";
    ".config/sketchybar/items/".source = "${./sketchybar-sh/items}";
    ".config/sketchybar/plugins/".source = "${./sketchybar-sh/plugins}";
  };

  services.sketchybar = lib.mkForce {
    enable = true;
    extraPackages = [pkgs.jq];
    config = ''
      #!/bin/bash

      source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors
      source "$HOME/.config/sketchybar/icons.sh"  # Loads all defined icons

      ITEM_DIR="$HOME/.config/sketchybar/items"     # Directory where the items are configured
      PLUGIN_DIR="$HOME/.config/sketchybar/plugins" # Directory where all the plugin scripts are stored

      FONT="Ubuntu Nerd Font" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
      PADDINGS=4              # All paddings use this value (icon, label, background)

      # Unload the macOS on screen indicator overlay for volume change
      launchctl unload -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist >/dev/null 3>&1 &

      # Setting up the general bar appearance of the bar
      sketchybar --bar height=32 \
        color=0x66000001 \
        shadow=on \
        position=top \
        sticky=on \
        padding_right=11 \
        padding_left=11 \
        corner_radius=16 \
        y_offset=5 \
        margin=11 \
        blur_radius=21 \
        notch_width=201

      # Setting up default values
      sketchybar --default updates=when_shown \
        icon.font="$FONT:Bold:16.0" \
        icon.color=$ICON_COLOR \
        icon.padding_left=$PADDINGS \
        icon.padding_right=$PADDINGS \
        label.font="$FONT:Semibold:14.0" \
        label.color=$LABEL_COLOR \
        label.padding_left=$PADDINGS \
        label.padding_right=$PADDINGS \
        padding_right=$PADDINGS \
        padding_left=$PADDINGS \
        background.height=31 \
        background.corner_radius=10 \
        popup.background.border_width=3 \
        popup.background.corner_radius=10 \
        popup.background.border_color=$POPUP_BORDER_COLOR \
        popup.background.color=$POPUP_BACKGROUND_COLOR \
        popup.blur_radius=21 \
        popup.background.shadow.drawing=on

      # Left
      [[ -f "$ITEM_DIR/apple.sh" ]] && source "$ITEM_DIR/apple.sh"
      [[ -f "$ITEM_DIR/spaces.sh" ]] && source "$ITEM_DIR/spaces.sh"
      [[ -f "$ITEM_DIR/front_app.sh" ]] && source "$ITEM_DIR/front_app.sh"
      # [[ -f "$ITEM_DIR/headphones.sh" ]] && source "$ITEM_DIR/headphones.sh"
      [[ -f "$ITEM_DIR/weather.sh" ]] && source "$ITEM_DIR/weather.sh"

      # Right
      [[ -f "$ITEM_DIR/calendar.sh" ]] && source "$ITEM_DIR/calendar.sh"
      [[ -f "$ITEM_DIR/brew.sh" ]] && source "$ITEM_DIR/brew.sh"
      [[ -f "$ITEM_DIR/battery.sh" ]] && source "$ITEM_DIR/battery.sh"
      # [[ -f "$ITEM_DIR/mic.sh" ]] && source "$ITEM_DIR/mic.sh"
      [[ -f "$ITEM_DIR/wifi.sh" ]] && source "$ITEM_DIR/wifi.sh"
      [[ -f "$ITEM_DIR/diskmonitor.sh" ]] && source "$ITEM_DIR/diskmonitor.sh"
      [[ -f "$ITEM_DIR/volume.sh" ]] && source "$ITEM_DIR/volume.sh"
      [[ -f "$ITEM_DIR/spotify.sh" ]] && source "$ITEM_DIR/spotify.sh"
      # [[ -f "$ITEM_DIR/messages.sh" ]] && source "$ITEM_DIR/messages.sh"

      # Forcing all item scripts to run (never do this outside of sketchybarrc)
      sketchybar --update

      echo "sketchybar configuration loaded.."
    '';
  };
}
