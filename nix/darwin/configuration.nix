{ config, pkgs, ... }:

let
  me = "jaredramirez";
  common = import ../common.nix {
    inherit pkgs;
    extraFishAliases = {
      kitty-ssh-cp = "infocmp xterm-kitty | ssh jared@home tic -x -o \~/.terminfo /dev/stdin";

      rep = "source $HOME/.config/kitty/workspaces/rep.sh";
      rep-api = "source $HOME/.config/kitty/workspaces/rep-api.sh";
      rep-dash = "source $HOME/.config/kitty/workspaces/rep-dash.sh";
      rep-portal = "source $HOME/.config/kitty/workspaces/rep-portal.sh";
      rep-join = "source $HOME/.config/kitty/workspaces/rep-join.sh";
      rep-collector = "source $HOME/.config/kitty/workspaces/rep-collector.sh";
      rep-community-dropoff = "source $HOME/.config/kitty/workspaces/rep-community-dropoff.sh";

      ssh-rep = "source $HOME/.config/kitty/workspaces/ssh-rep.sh";
      ssh-rep-community-dropoff = "source $HOME/.config/kitty/workspaces/ssh-rep-community-dropoff.sh";

      dotfiles = "source $HOME/.config/kitty/workspaces/dotfiles.sh";

      ssh-dotfiles = "source $HOME/.config/kitty/workspaces/ssh-dotfiles.sh";
    };
  };
in
{
  # List packages installed in system profile
  # System-Wide and nearly all stuff for Neovim
  environment.systemPackages = common.systemPackages ++ [
    # (import ../extra/kakoune-cr.nix { pkgs = pkgs; isMacos = true; })
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
  fonts.enableFontDir = true;
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

  # Link wezterm
  environment.pathsToLink = [ "/share" "/bin" "/Applications" ];

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
