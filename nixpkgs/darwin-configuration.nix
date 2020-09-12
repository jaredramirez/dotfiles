{ config, pkgs, ... }:

let
  me = "jaredramirez";
in
{
  # List packages installed in system profile
  environment.systemPackages =
    [ pkgs.vim
      pkgs.kitty
      pkgs.neovim
      pkgs.starship
      (pkgs.callPackage ./extras/firefox.nix { })
      (pkgs.callPackage ./extras/alfred.nix { })

      # JS
      pkgs.nodejs-14_x
      pkgs.yarn

      # HS
      pkgs.ormolu
      (import (builtins.fetchGit {
        url = "https://github.com/korayal/hls-nix.git";
        rev = "33c55f4574415c4c64a20ca3c4a715e811339cc9";
      }) {}).hpkgs.haskell-language-server

      pkgs.gitAndTools.gh
      pkgs.gitAndTools.delta
      pkgs.heroku
      pkgs.nix-prefetch-git
      pkgs.amber
      pkgs.silver-searcher
      pkgs.expect
    ];


  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs = {
    zsh.enable = true;

    fish = {
      enable = true;
      shellInit = ''
        # Set global variables
        set -gx EDITOR nvim
        set -gx LANG "en_US.UTF-8"
        set -gx DOTFILES "$HOME/dev/github.com/jaredramirez/dotfiles"
        set -gx SHELL "/run/current-system/sw/bin/fish"
        set -gx FZF_DEFAULT_COMMAND "ag_with_ignores"
        set -gx PATH "$HOME/.local/bin" $PATH
      '';
      promptInit = ''
        fish_vi_key_bindings

        set -gx STARSHIP_CONFIG "$HOME/.config/fish/starship.toml"
        starship init fish | source
      '';
      shellAliases = {
        work = "source $DOTFILES/kitty/sessions/work-session.fish";
        nix_search = "nix-env -qaP | ag";
        nvim_update = "nvim +PlugInstall +UpdateRemotePlugins +qa";
        oni2 = "/Applications/Onivim2.app/Contents/Resources/run.sh";
        reload = "darwin-rebuild switch && source ~/.config/fish/config.fish";
        git_branch_cleanup = "git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";
      };
    };
  };

  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_12;
      dataDir = "/var/lib/postgresql/12.4";
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

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.tilesize = 32;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
