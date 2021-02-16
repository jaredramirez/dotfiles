{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, hardwareConfig }: {
    nixosConfigurations.home = {
      system = "x86_64-linux";
      modules = [ ./nix/nixos/configuration.nix ];
    };
  };
}
