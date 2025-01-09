{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    {
      nixpkgs,
      nvf,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      configModule = import ./configuration.nix false;
      customNeovim = nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ configModule ];
      };
    in
    {
      packages.${system}.default = customNeovim.neovim;
    };
}
