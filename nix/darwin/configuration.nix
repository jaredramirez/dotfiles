{ config, pkgs, ... }:

let
  me = "jaredramirez";
  common = import ../common.nix {
    inherit pkgs;
    extraFishAliases = {
        kitty-ssh-cp = "infocmp xterm-kitty | ssh jared@home tic -x -o \~/.terminfo /dev/stdin";

        rep = "source $HOME/.config/kitty/workspaces/rep.sh";
        ssh-rep = "source $HOME/.config/kitty/workspaces/ssh-rep.sh";
        dotfiles = "source $HOME/.config/kitty/workspaces/dotfiles.sh";
    };
  };
in
{
  # List packages installed in system profile
  # System-Wide and nearly all stuff for Neovim
  environment.systemPackages = common.systemPackages ++ [
    pkgs.kitty
  ];
  environment.variables = common.variables;

  environment.systemPath = [
    "$HOME/.local/bin"
  ];

  programs.zsh = common.programs.zsh;
  programs.bash = common.programs.bash;
  programs.fish = common.programs.fish // {
    useBabelfish = true;
    babelfishPackage = pkgs.babelfish;
  };

  # No need to menion zsh or dash here, as it's defaultly available on macos
  environment.shells = [ pkgs.fish ];

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

  # Lorri
  services.lorri.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
