{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      nvf,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        configModule = import ./configuration.nix false;
        customNeovim = nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [ configModule ];
        };
      in
      {
        formatter = pkgs.nixfmt-rfc-style;
        packages.default = customNeovim.neovim;
      }
    );
}
