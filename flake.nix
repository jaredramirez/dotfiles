{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin }: {
    nixosConfigurations.home = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nix/nixos/configuration.nix
        ./nix/nixos/hardware-configuration.nix
      ];
    };

    darwinConfigurations."Jareds-MBP-2" = darwin.lib.darwinSystem {
      inputs = { inherit nixpkgs; };
      modules = [ ./nix/darwin/configuration.nix ];
    };
  };
}
