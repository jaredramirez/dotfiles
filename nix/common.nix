{ pkgs, extraFishAliases }:

{
  systemPackages =
    with pkgs; [
      # Terminal
      wezterm

      # Editor
      neovim
      kakoune
      nodePackages.prettier
      xsel
      rustc # Needed to build kak-lsp
      cargo # Needed to build kak-lsp

      # Global language servers
      nodePackages.yaml-language-server
      rnix-lsp
      (import ./extra/rescript-language-server.nix { pkgs = pkgs; })

      # Global formatters
      nixpkgs-fmt

      # Common tools
      git
      skim
      fzf
      ripgrep
      # amber # as of 04/29/2021 amber errors when building
      gitAndTools.gh
      gitAndTools.delta
      heroku
      nix-prefetch-git
      starship
      bat

      # Nix helpers
      cachix
      direnv
    ];

  variables = {
    LANG = "en_US.UTF-8";
  };

  programs = {
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
