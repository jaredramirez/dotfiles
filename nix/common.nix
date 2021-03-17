{ pkgs }:

# let
  # isMacOS = builtins.currentSystem == "x86_64-darwin";
# in
{ systemPackages =
    [ pkgs.git
      pkgs.kakoune
      pkgs.kak-lsp
      pkgs.fzf
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
      pkgs.kitty
      pkgs.tab-rs

      # Neovim deps
      pkgs.neovim-nightly
      pkgs.tree-sitter
      pkgs.python3
      pkgs.python3Packages.pynvim

      # Nix helpers
      pkgs.cachix
      pkgs.direnv
      pkgs.nix-direnv

      # Needed globally for Coc
      pkgs.nodejs-14_x
      (pkgs.yarn.override { nodejs = pkgs.nodejs-14_x; })
    ];

  variables = {
    LANG = "en_US.UTF-8";
    DIRENV_WARN_TIMEOUT = "15s";
  };

  programs =  {
    zsh = {
      enable = true;
      interactiveShellInit = ''
        bindkey -v
        eval "$(starship init zsh)"
      '';
      shellInit = ''
        export EDITOR=nvim
        eval "$(direnv hook zsh)"
      '';
    };

    bash = {
      # Nix-darwin doesn't support shellInit
      interactiveShellInit = ''
        export EDITOR=nvim
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
        set -gx EDITOR nvim
        direnv hook fish | source
      '';
      shellAliases = {
        k = "kak";
        ssh-rep = "ssh jared@home -L 2000:localhost:2000 -L 4000:localhost:4000 -L 5000:localhost:5000 -L 9000:localhost:9000 -L 8081:localhost:8081 -L 19000:localhost:19000 -L 19001:localhost:19001 -L 19002:localhost:19002 -t \"cd ~/dev/github/replenysh/core; tab\"";
        rep = "cd ~/dev/github/replenysh/core; tab";
        nix-env = "direnv allow .";
        nix-search = "nix-env -qaP | ag";
        nvim-update = "nvim +PlugInstall +UpdateRemotePlugins +qa";
        git-branch-cleanup = "git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";

	# Legacy nvim alias
        nv = "nvim";

        # Legacy kitty stuff (before I started using tab-rs)
        ssh-cp-kitty = "infocmp xterm-kitty | ssh jared@home tic -x -o \~/.terminfo /dev/stdin";
        ws-rep = "source $HOME/.config/kitty/workspaces/rep.fish";
        ws-rep-ssh = "source $HOME/.config/kitty/workspaces/ssh-rep.fish";
        ws-roc = "source $HOME/.config/kitty/workspaces/roc.fish";
        ws-roc-ssh = "source $HOME/.config/kitty/workspaces/ssh-roc.fish";
      };
    };
  };
}
