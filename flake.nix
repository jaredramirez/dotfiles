{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, nixos-hardware }: {
    nixosConfigurations.home = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nix/nixos/configuration.nix
        ./nix/nixos/hardware-configuration.nix
      ];
    };
  };
}
