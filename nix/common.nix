{ pkgs }:

let
  isMacOS = builtins.currentSystem == "x86_64-darwin";
in
{ systemPackages = 
    [ pkgs.git
      pkgs.neovim
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
        direnv hook fish | source
        starship init fish | source
      '';
      shellInit = ''
        set -gx EDITOR nvim
        direnv hook fish | source
        direnv export fish | source
      '';
      shellAliases = {
        nv = "nvim";
        ws-rep = "source $HOME/.config/kitty/workspaces/rep.fish";
        ws-rep-ssh = "source $HOME/.config/kitty/workspaces/ssh-rep.fish";
        ws-roc = "source $HOME/.config/kitty/workspaces/roc.fish";
        ws-roc-ssh = "source $HOME/.config/kitty/workspaces/ssh-roc.fish";
        ssh-cp-kitty = "infocmp xterm-kitty | ssh jared@home tic -x -o \~/.terminfo /dev/stdin";
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
