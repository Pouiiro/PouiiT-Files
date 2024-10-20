# This is your nix-darwin configuration.
# For home configuration, see /modules/home/*
{
  flake,
  pkgs,
  lib,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    # Services
    ./services/yabai.nix
    ./services/skhd.nix
    ./services/sketchybar.nix

    # System
    ./system.nix
    ./fonts.nix
  ];

  services.nix-daemon.enable = true;

  # Use TouchID for `sudo` authentication
  security.pam.enableSudoTouchIdAuth = true;

  # These users can add Nix caches.
  nix.settings.trusted-users = ["root" "johnDoe"];
}
