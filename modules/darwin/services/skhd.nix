{lib, ...}: {
  # gotta do "launchctl stop org.nixos.skhd"
  # see https://github.com/LnL7/nix-darwin/issues/969
  services.skhd = lib.mkForce {
    enable = true;
    skhdConfig = ''
      # Change window focus within space
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - h : yabai -m window --focus west
      alt - l : yabai -m window --focus east

      # Change focus between external displays (left and right)
      alt - s : yabai -m display --focus west
      alt - g : yabai -m display --focus east

      # Rotate layout clockwise
      shift + alt - r : yabai -m space --rotate 270

      # Flip along y-axis
      shift + alt - y : yabai -m space --mirror y-axis

      # Flip along x-axis
      shift + alt - x : yabai -m space --mirror x-axis

      # Toggle window float
      shift + alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:2

      # Maximize a window
      shift + alt - m : yabai -m window --toggle zoom-fullscreen

      # Balance out tree of windows (resize to occupy same area)
      shift + alt - e : yabai -m space --balance

      # Swap windows
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - h : yabai -m window --swap west
      shift + alt - l : yabai -m window --swap east

      # Move window and split
      ctrl + alt - j : yabai -m window --warp south
      ctrl + alt - k : yabai -m window --warp north
      ctrl + alt - h : yabai -m window --warp west
      ctrl + alt - l : yabai -m window --warp east

      # Move window to display left and right
      shift + alt - s : yabai -m window --display west; yabai -m display --focus west
      shift + alt - g : yabai -m window --display east; yabai -m display --focus east

      # Move window to previous and next space
      shift + alt - p : yabai -m window --space prev
      shift + alt - n : yabai -m window --space next

      # Move window to space #
      shift + alt - 1 : yabai -m window --space 1
      shift + alt - 2 : yabai -m window --space 2
      shift + alt - 3 : yabai -m window --space 3
      shift + alt - 4 : yabai -m window --space 4
      shift + alt - 5 : yabai -m window --space 5
      shift + alt - 6 : yabai -m window --space 6
      shift + alt - 7 : yabai -m window --space 7

      # Stop/start/restart yabai
      ctrl + alt - q : brew services stop yabai
      ctrl + alt - s : brew services start yabai
      ctrl + alt - r : brew services restart yabai

      # Toggle window float and update SketchyBar
      lalt - space : yabai -m window --toggle float; sketchybar --trigger window_focus
      shift + lalt - f : yabai -m window --toggle zoom-fullscreen; sketchybar --trigger window_focus
      lalt - f : yabai -m window --toggle zoom-parent; sketchybar --trigger window_focus
      shift + lalt - 1 : yabai -m window --space 1 && sketchybar --trigger windows_on_spaces

      # Send window to desktop and follow focus
      shift + cmd - x : yabai -m window --space recent; yabai -m space --focus recent
      shift + cmd - z : yabai -m window --space prev; yabai -m space --focus prev
      shift + cmd - 1 : yabai -m window --space 1; yabai -m space --focus 1
      shift + cmd - 2 : yabai -m window --space 2; yabai -m space --focus 2
      shift + cmd - 5 : yabai -m window --space 5; yabai -m space --focus 5
      shift + cmd - 6 : yabai -m window --space 6; yabai -m space --focus 6
      shift + cmd - 7 : yabai -m window --space 7; yabai -m space --focus 7
      shift + cmd - 8 : yabai -m window --space 8; yabai -m space --focus 8
      shift + cmd - 9 : yabai -m window --space 9; yabai -m space --focus 9
      shift + cmd - 0 : yabai -m window --space 10; yabai -m space --focus 10

      # Increase window size
      shift + alt - a : yabai -m window --resize left:-20:0
      shift + alt - s : yabai -m window --resize bottom:0:20
      shift + alt - w : yabai -m window --resize top:0:-20
      shift + alt - d : yabai -m window --resize right:20:0

      # Decrease window size
      shift + cmd - a : yabai -m window --resize left:20:0
      shift + cmd - s : yabai -m window --resize bottom:0:-20
      shift + cmd - w : yabai -m window --resize top:0:20
      shift + cmd - d : yabai -m window --resize right:-20:0
    '';
  };
}
