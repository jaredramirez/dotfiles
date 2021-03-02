{ config, pkgs, ... }:

let
  me = "jaredramirez";
  common = import ../common.nix { inherit pkgs; };
in
{
  # List packages installed in system profile
  # System-Wide and nearly all stuff for Neovim
  environment.systemPackages = common.systemPackages;

  environment.variables = common.variables;

  environment.systemPath = [
    "$HOME/.local/bin"
    "${pkgs.wezterm}/Applications/WezTerm.app"
  ];

  programs.zsh = common.programs.zsh;
  programs.bash = common.programs.bash;
  programs.fish = common.programs.fish // {
    useBabelfish = true;
    babelfishPackage = pkgs.babelfish;
  };

  # No need to menion zsh here, as it's defaultly available on macos
  environment.shells = [ pkgs.fish ];

  # Allow Application to be found by spotlight
  system.activationScripts.applications.text = pkgs.lib.mkForce (''
    echo "setting up ~/Applications/Nix..."
    rm -rf ~/Applications/Nix
    mkdir -p ~/Applications/Nix
    chown ${me} ~/Applications/Nix
    find ${config.system.build.applications}/Applications -maxdepth 1 -type l | while read f; do
      src="$(/usr/bin/stat -f%Y $f)"
      appname="$(basename $src)"
      osascript -e "tell app \"Finder\" to make alias file at POSIX file \"/Users/${me}/Applications/Nix/\" to POSIX file \"$src\" with properties {name: \"$appname\"}";
    done
  '');

  # Fonts
  fonts.fonts = [
    pkgs.fira-code
  ];

  # Users
  nix.trustedUsers = [ "root" "jaredramirez" ];

  # MacOS Stuff
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.tilesize = 32;

  # nix-direnv options
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
