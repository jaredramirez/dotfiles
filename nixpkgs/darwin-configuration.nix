{ config, pkgs, ... }:

let
  me = "jaredramirez";
in
{
  # List packages installed in system profile
  # System-Wide and nearly all stuff for Neovim
  environment.systemPackages =
    [ # Applications
      pkgs.kitty
      pkgs.neovim
      pkgs.dash
      pkgs.kakoune
      pkgs.kak-lsp
      (pkgs.callPackage ./extras/firefox.nix { })
      (pkgs.callPackage ./extras/alfred.nix { })

      # Tools
      pkgs.cachix
      pkgs.direnv
      pkgs.nix-direnv
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

      # Needed for Coc
      pkgs.nodejs-14_x
      pkgs.yarn
    ];


  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  environment.variables = {
      EDITOR = "kak";
      LANG = "en_US.UTF-8";
      DIRENV_WARN_TIMEOUT = "15s";
      KAKOUNE_POSIX_SHELL = "${pkgs.dash}/bin/dash";
  };

  environment.systemPath = [
      "$HOME/.local/bin"
  ];

  programs = {
    zsh.enable = true;
    fish = {
      enable = true;
      shellInit = ''
        # Set global variables
        set -gx FZF_DEFAULT_COMMAND "rg_with_ignores"
        set -gx SKIM_DEFAULT_COMMAND "rg_with_ignores"
      '';
      promptInit = ''
        fish_vi_key_bindings

        starship init fish | source

        direnv hook fish | source
        direnv export fish | source
      '';
      shellAliases = {
        nv = "nvim";
        ws-rep = "source $HOME/.config/kitty/workspaces/rep.fish";
        ws-roc = "source $HOME/.config/kitty/workspaces/roc.fish";
        nix-env = "direnv allow .";
        nix-search = "nix-env -qaP | ag";
        nix-switch = "darwin-rebuild switch";
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
  environment.pathsToLink =
    [ "/share/nix-direnv"
    ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
