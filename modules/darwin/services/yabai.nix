{lib, ...}: {
  services.yabai = lib.mkForce {
    enable = true;
    enableScriptingAddition = true;
    config = {
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      window_placement = "second_child";
      #   window_opacity               = "off";
      #   window_opacity_duration      = "0.0";
      #   window_border                = "on";
      #   window_border_placement      = "inset";
      #   window_border_width          = 2;
      #   window_border_radius         = 3;
      #   active_window_border_topmost = "off";
      #   window_topmost               = "on";
      #   window_shadow                = "float";
      #   active_window_border_color   = "0xff5c7e81";
      #   normal_window_border_color   = "0xff505050";
      #   insert_window_border_color   = "0xffd75f5f";
      #   active_window_opacity        = "1.0";
      #   normal_window_opacity        = "1.0";
      #   split_ratio                  = "0.50";
      #   auto_balance                 = "on";
      mouse_modifier = "alt";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout = "bsp";
      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;
      window_gap = 12;
    };

    extraConfig = ''
      # yabai -m config external_bar all:40:0
      yabai -m config --dispaly 1 external_bar all:40:0
      yabai -m mouse_drop_action swap

      # disable some apps
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^Calculator$" manage=off
      yabai -m rule --add app="^Karabiner-Elements$" manage=off

      yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
      yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
      yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"

      yabai -m rule --add app="^Arc$" manage=off
      yabai -m signal --add event=window_created app="^Arc$" action="~/.scripts/yabai_apply_arc_rules.sh"
    '';
  };
}
