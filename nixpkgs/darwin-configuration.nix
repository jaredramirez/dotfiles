{ config, pkgs, ... }:

let
  me = "jaredramirez";
in
{
  # List packages installed in system profile
  # System-Wide and nearly all stuff for Neovim
  environment.systemPackages =
    [ # GUI Apps
      pkgs.kitty
      (pkgs.callPackage ./extras/firefox.nix { })

      # CLI Apps
      pkgs.neovim
      pkgs.fzf
      pkgs.skim
      pkgs.ripgrep
      pkgs.amber
      pkgs.gitAndTools.gh
      pkgs.gitAndTools.delta
      pkgs.heroku
      pkgs.nix-prefetch-git
      pkgs.starship
      pkgs.bat

      # Nix helpers
      pkgs.cachix
      pkgs.direnv
      pkgs.nix-direnv

      # Needed globally for Coc
      pkgs.nodejs-14_x
      pkgs.yarn
    ];

  environment.variables = {
    EDITOR = "nvim";
    LANG = "en_US.UTF-8";
    DIRENV_WARN_TIMEOUT = "15s";
    SKIM_DEFAULT_OPTIONS = "--height 50% --layout=reverse";
  };

  environment.systemPath = [
    "$HOME/.local/bin"
  ];

  # No need to menion zsh here, as it's defaultly available on macos
  environment.shells = [
    pkgs.fish
  ];

  programs = {
    zsh = {
      enable = true;
      interactiveShellInit = ''
        bindkey -v
        eval "$(starship init zsh)"
      '';
      shellInit = ''
        # export SHELL="${pkgs.zsh}"
        eval "$(direnv hook zsh)"
      '';
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        fish_vi_key_bindings
        direnv hook fish | source
        starship init fish | source
      '';
      shellInit = ''
        # set -gx SHELL ${pkgs.fish}
        direnv hook fish | source
        direnv export fish | source
      '';
      shellAliases = {
        nv = "nvim";
        ws-rep = "source $HOME/.config/kitty/workspaces/rep.fish";
        ws-roc = "source $HOME/.config/kitty/workspaces/roc.fish";
        nix-env = "direnv allow .";
        nix-search = "nix-env -qaP | ag";
        nix-switch = "darwin-rebuild switch && source /etc/fish/config.fish";
        nvim-update = "nvim +PlugInstall +UpdateRemotePlugins +qa";
        git-branch-cleanup = "git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";
      };
    };
  };

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

  # MacOS Stuff
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.tilesize = 32;

  # nix-direnv options
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
