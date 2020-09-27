#!/bin/sh

PWD=`pwd`

# Link nix-darwin
DARWIN_CONFIG="darwin-configuration.nix"
HOME_DARWIN_CONFIG="$HOME/.nixpkgs/$DARWIN_CONFIG"
if [ -e "$HOME_DARWIN_CONFIG" ]
  then mv "$HOME_DARWIN_CONFIG" "$HOME_DARWIN_CONFIG.backup"
fi
ln -s "$PWD/nixpkgs/$DARWIN_CONFIG" "$HOME_DARWIN_CONFIG"

NIX_EXTRAS="extras"
HOME_NIX_EXTRAS="$HOME/.nixpkgs/$NIX_EXTRAS"
if [ -e "$HOME_NIX_EXTRAS" ]
  then mv "$HOME_NIX_EXTRAS" "$HOME_NIX_EXTRAS.backup"
fi
ln -s "$PWD/nixpkgs/$NIX_EXTRAS" "$HOME_NIX_EXTRAS"

# Link Fish
FISH_FUNCTIONS_INIT="functions"
HOME_FISH_FUNCTIONS="$HOME/.config/fish/$FISH_FUNCTIONS_INIT"
if [ -e "$HOME_FISH_FUNCTIONS" ]
  then mv "$HOME_FISH_FUNCTIONS" "$HOME_FISH_FUNCTIONS.backup"
fi
ln -s "$PWD/fish/$FISH_FUNCTIONS_INIT" $HOME_FISH_FUNCTIONS

# Link Neovim
NVIM_INIT="init.vim"
HOME_NVIM="$HOME/.config/nvim/$NVIM_INIT"
if [ -e "$HOME_NVIM" ]
  then mv "$HOME_NVIM" "$HOME_NVIM.backup"
fi
ln -s "$PWD/nvim/$NVIM_INIT" $HOME_NVIM

# Link Kitty
KITTY_INIT="kitty.conf"
HOME_KITTY="$HOME/.config/kitty/$KITTY_INIT"
if [ -e "$HOME_KITTY" ]
  then mv "$HOME_KITTY" "$HOME_KITTY.backup"
fi
ln -s "$PWD/kitty/$KITTY_INIT" $HOME_KITTY

KITTY_WORKSPACES="workspaces"
HOME_KITTY_WORKSPACES="$HOME/.config/kitty/$KITTY_WORKSPACES"
if [ -e "$HOME_KITTY_WORKSPACES" ]
  then mv "$HOME_KITTY_WORKSPACES" "$HOME_KITTY_WORKSPACES.backup"
fi
ln -s "$PWD/kitty/$KITTY_WORKSPACES" $HOME_KITTY_WORKSPACES

KITTY_THEMES="themes"
HOME_KITTY_THEMES="$HOME/.config/kitty/$KITTY_THEMES"
if [ -e "$HOME_KITTY_THEMES" ]
  then mv "$HOME_KITTY_THEMES" "$HOME_KITTY_THEMES.backup"
fi
ln -s "$PWD/kitty/$KITTY_THEMES" $HOME_KITTY_THEMES

# Link Neovim
STARSHIP_INIT="starship.toml"
HOME_STARSHIP="$HOME/.config/$STARSHIP_INIT"
if [ -e "$HOME_STARSHIP" ]
  then mv "$HOME_STARSHIP" "$HOME_STARSHIP.backup"
fi
ln -s "$PWD/starship/$STARSHIP_INIT" $HOME_STARSHIP

# Link nix-direnv
DIRENV_CONFIG="direnvrc"
HOME_DIRENV_CONFIG="$HOME/.$DIRENV_CONFIG"
if [ -e "$HOME_DIRENV_CONFIG" ]
  then mv "$HOME_DIRENV_CONFIG" "$HOME_DIRENV_CONFIG.backup"
fi
ln -s "$PWD/direnv/$DIRENV_CONFIG" "$HOME_DIRENV_CONFIG"

# Link git
GIT_CONFIG="gitconfig"
HOME_GIT_CONFIG="$HOME/.$GIT_CONFIG"
if [ -e "$HOME_GIT_CONFIG" ]
  then mv "$HOME_GIT_CONFIG" "$HOME_GIT_CONFIG.backup"
fi
ln -s "$PWD/git/$GIT_CONFIG" "$HOME_GIT_CONFIG"
