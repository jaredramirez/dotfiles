{ pkgs }:

# let
  # isMacOS = builtins.currentSystem == "x86_64-darwin";
# in
{ systemPackages =
    [ pkgs.git
      pkgs.kakoune
      # pkgs.kakoune-cr
      pkgs.kak-lsp
      pkgs.skim
      pkgs.ripgrep
      pkgs.amber
      pkgs.gitAndTools.gh
      pkgs.gitAndTools.delta
      pkgs.heroku
      pkgs.nix-prefetch-git
      pkgs.starship
      pkgs.bat
      pkgs.docker
      pkgs.alacritty
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
        direnv hook fish | source
      '';
    };

    bash = {
      # Nix-darwin doesn't support shellInit
      interactiveShellInit = ''
        export EDITOR=kak
        direnv hook fish | source
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
        set -gx EDITOR kak
        direnv hook fish | source
      '';
      shellAliases = {
        k = "kak";
        nix-search = "nix-env -qaP | ag";
        nvim-update = "nvim +PlugInstall +UpdateRemotePlugins +qa";
        git-branch-cleanup = "git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";

	# tab
        ssh-rep = "ssh jared@home -L 2000:localhost:2000 -L 4000:localhost:4000 -L 5000:localhost:5000 -L 9000:localhost:9000 -L 8081:localhost:8081 -L 19000:localhost:19000 -L 19001:localhost:19001 -L 19002:localhost:19002 -t \"tab replenysh-core\"";
        rep = "tab replenysh-core";

        ssh-dotfiles = "ssh jared@home -t \"tab dotfiles\"";
        dotfiles = "tab dotfiles";
      };
    };
  };
}
