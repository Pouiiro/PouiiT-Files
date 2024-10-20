{inputs, ...}: let
  myNixCats = import ../../nvim/nixGattos.nix {inherit inputs;};
in {
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      name = "Pouiix";
      meta.description = "Shell environment for modifying this Nix configuration";
      packages = with pkgs; [
        just
        nixd
        myNixCats.packages.${pkgs.system}.nvim
      ];
    };
  };
}
