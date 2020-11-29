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
      interactiveShellInit = ''
        eval "$(starship init bash)"
      '';
      shellInit = ''
        export EDITOR=nvim
        eval "$(direnv hook bash)"
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
        ws-roc = "source $HOME/.config/kitty/workspaces/roc.fish";
        nix-env = "direnv allow .";
        nix-search = "nix-env -qaP | ag";
        nix-switch =
          if isMacOS
            then "darwin-rebuild switch"
            else "sudo nixos-rebuild switch";
        nvim-update = "nvim +PlugInstall +UpdateRemotePlugins +qa";
        git-branch-cleanup = "git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";
        tmux = "tmux -2";
      };
    };

    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      shortcut = "a";
      extraConfig = ''
        # Smart pane switching with awareness of Vim splits.
        # See: https://github.com/christoomey/vim-tmux-navigator
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l

        set -g default-terminal "xterm-256color"
        set-option -ga terminal-overrides ",xterm-256color:Tc"
      '';
    };
  };
}
