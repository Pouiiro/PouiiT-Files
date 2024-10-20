{lib, ...}: {
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      shell_integration = "enabled";
      placement_strategy = "center";
      window_margin_width = 0;

      cursor_shape = "block";
      cursor_underline_thickness = "6.5";
      cursor_beam_thickness = "3.5";
      cursor_blink_interval = "0.25";
      undercurl_style = "thick-dense";

      # Opacity
      background_opacity = "0.85";
      background_blur = 3;
      second_transparent_bg = "#210f2e";

      # Title bar
      hide_window_decorations = "titlebar-only";

      # Tab bar settings
      tab_bar_min_tabs = 2;
      tab_bar_background = "none";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{tab.active_wd.replace('/Users/ouailb/', '')}";
      active_tab_title_template = "  ~ {tab.active_wd.replace('/Users/johnDoe/', '')}";

      # Paddings
      window_border_width = 0;
      draw_minimal_borders = false;
      active_border_color = "none";

      # Performance settings
      input_delay = 0;
      repaint_delay = 2;
      sync_to_monitor = false;
      wayland_enable_ime = false;

      # Tab bar extras
      active_tab_font_style = "bold_italic";
      inactive_tab_font_style = "thin";

      # Fonts
      font_family = "family='JetBrains Mono' style='SemiBold'";
      bold_font = "family='JetBrains Mono' style='ExtraBold'";
      italic_font = "family='JetBrains Mono' style='SemiBold Italic'";
      bold_italic_font = "family='JetBrains Mono' style='ExtraBold Italic'";
      font_size = 16;

      # Include extras
      include = "./custom/kitty/gatto.conf";
    };

    extraConfig = ''
      map kitty_mod+enter launch --cwd=current --type=window
      defaults write -g NSWindowShouldDragOnGesture YES
      map ctrl+shift+j send_text all \x1b[74;5u

      modify_font cell_height 130%
      modify_font cell_width 95%
      modify_font underline_position 7

      # vim:ft=kitty

      ## name: Catppuccin Kitty Mocha
      ## author: Catppuccin Org
      ## license: MIT
      ## upstream: https://github.com/catppuccin/kitty/blob/main/themes/mocha.conf
      ## blurb: Soothing pastel theme for the high-spirited!

      # The basic colors
      foreground              #cdd6f4
      background              #000000
      selection_foreground    #1e1e2e
      selection_background    #f5e0dc

      # Cursor colors
      cursor                  #ff0000
      cursor_text_color       #1e1e2e

      # URL underline color when hovering with mouse
      url_color               #f5e0dc

      # Kitty window border colors
      active_border_color     #b4befe
      inactive_border_color   #6c7086
      bell_border_color       #f9e2af

      # OS Window titlebar colors
      wayland_titlebar_color system
      macos_titlebar_color system

      # Tab bar colors
      active_tab_foreground   #ff0000
      active_tab_background   #000000
      inactive_tab_foreground #525561
      inactive_tab_background #000000
      tab_bar_background      #000000

      # Colors for marks (marked text in the terminal)
      mark1_foreground #1e1e2e
      mark1_background #b4befe
      mark2_foreground #1e1e2e
      mark2_background #cba6f7
      mark3_foreground #1e1e2e
      mark3_background #74c7ec

      # The 16 terminal colors

      # black
      color0 #45475a
      color8 #9a9ca9

      # red
      color1 #f38ba8
      color9 #f38ba8

      # green
      color2  #a6e3a1
      color10 #a6e3a1

      # yellow
      color3  #f9e2af
      color11 #f9e2af

      # blue
      color4  #89b4fa
      color12 #89b4fa

      # magenta
      color5  #f5c2e7
      color13 #f5c2e7

      # cyan
      color6  #94e2d5
      color14 #94e2d5

      # white
      color7  #bac2de
      color15 #a6adc8
    '';
  };
}
