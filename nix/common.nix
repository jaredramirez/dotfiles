{ pkgs, extraFishAliases }:

# let
  # isMacOS = builtins.currentSystem == "x86_64-darwin";
# in
{ systemPackages =
    with pkgs; [
      # Editor
      kakoune
      kak-lsp
      nodePackages.prettier

      # Common tools
      git
      coreutils
      fzf
      jq
      ripgrep
      # amber
      gitAndTools.gh
      gitAndTools.delta
      heroku
      nix-prefetch-git
      starship
      bat
      docker
      tab-rs

      # Necessary to be installed gobally
      nodePackages.expo-cli

      # Nix helpers
      cachix
      direnv

      # Needed globally for Coc
      nodejs-14_x
      (yarn.override { nodejs = nodejs-14_x; })
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
