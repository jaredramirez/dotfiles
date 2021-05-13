{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin }:
    let
      overlays = [ ];

      macbookConfig =
        darwin.lib.darwinSystem {
          inputs = { inherit darwin nixpkgs; };
          modules = [
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = overlays;
            })
            ./nix/darwin/configuration.nix
          ];
        };

    in
    {
      nixosConfigurations.home = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = overlays;
          })
          ./nix/nixos/configuration.nix
          ./nix/nixos/hardware-configuration.nix
        ];

      };

      darwinConfigurations."Jareds-MacBook-Pro" = macbookConfig;
      darwinConfigurations."Jareds-Work-MacBook-Pro" = macbookConfig;
      darwinConfigurations.MorganisBeyotch.localdomain = macbookConfig;
    };
}
