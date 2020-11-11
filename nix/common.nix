{ pkgs }:

let
  isMacOS = builtins.currentSystem == "x86_64-darwin";
in
{ systemPackages = 
    [ pkgs.git
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

  variables = {
    EDITOR = "nvim";
    LANG = "en_US.UTF-8";
    DIRENV_WARN_TIMEOUT = "15s";
    SKIM_DEFAULT_OPTIONS = "--height 50% --layout=reverse";
  };

  programs =  {
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
        nix-switch =
          if isMacOS
            then "darwin-rebuild switch"
            else "sudo nixos-rebuild switch";
        nvim-update = "nvim +PlugInstall +UpdateRemotePlugins +qa";
        git-branch-cleanup = "git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";
      };
    };
  };
}
