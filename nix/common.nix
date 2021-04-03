{ pkgs, extraFishAliases }:

# let
  # isMacOS = builtins.currentSystem == "x86_64-darwin";
# in
{ systemPackages =
    [ pkgs.git
      pkgs.kakoune
      # pkgs.kakoune-cr
      pkgs.kak-lsp
      pkgs.coreutils
      pkgs.fzf
      pkgs.jq
      pkgs.mktemp
      pkgs.ripgrep
      pkgs.amber
      pkgs.gitAndTools.gh
      pkgs.gitAndTools.delta
      pkgs.heroku
      pkgs.nix-prefetch-git
      pkgs.starship
      pkgs.bat
      pkgs.docker
      pkgs.tab-rs

      # Nix helpers
      pkgs.cachix
      pkgs.direnv

      # Needed globally for Coc
      pkgs.nodejs-14_x
      (pkgs.yarn.override { nodejs = pkgs.nodejs-14_x; })
    ];

  variables = {
    LANG = "en_US.UTF-8";
  };

  programs =  {
    zsh = {
      enable = true;
      interactiveShellInit = ''
        bindkey -v
        eval "$(starship init zsh)"
      '';
      shellInit = ''
        export EDITOR=kak
        export PATH=$PATH:"$HOME/.local/bin"

        eval "$(direnv hook zsh)"
      '';
    };

    bash = {
      # Nix-darwin doesn't support shellInit
      interactiveShellInit = ''
        export EDITOR=kak
        export PATH=$PATH:"$HOME/.local/bin"

        eval "$(direnv hook bash)"
        eval "$(starship init bash)"
      '';
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
      promptInit = ''
        starship init fish | source
      '';
      shellInit = ''
        contains "$HOME/.local/bin" $fish_user_paths; or set -Ua fish_user_paths "$HOME/.local/bin"

        set -gx EDITOR kak
        direnv hook fish | source
      '';
      shellAliases = {
        k = "kak";
        nix-search = "nix-env -qaP | ag";
        nvim-update = "nvim +PlugInstall +UpdateRemotePlugins +qa";
        git-branch-cleanup = "git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";
      } // extraFishAliases;
    };
  };
}
