{
  pkgs,
  flake,
  ...
}: let
  inherit (flake) inputs;
  myNixCats = import ../../nvim/nixGattos.nix {inherit inputs;};
in {
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Unix tools
    ripgrep # Better `grep`
    fd
    sd
    tree

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    alejandra

    # Dev
    tmate
    nodejs
    pnpm
    myNixCats.packages.${pkgs.system}.nvim

    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less

    # System apps
    gimp
    keycastr
  ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    # Better `cat`
    bat.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    jq.enable = true;
    # Install btop https://github.com/aristocratos/btop
    btop.enable = true;
  };
}
