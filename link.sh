#!/bin/sh

PWD=`pwd`

# Link nix-darwin
DARWIN_CONFIG="darwin-configuration.nix"
HOME_DARWIN_CONFIG="$HOME/.nixpkgs/$DARWIN_CONFIG"
if [ -e "$HOME_DARWIN_CONFIG" ]
  then cp -r "$HOME_DARWIN_CONFIG" "$HOME_DARWIN_CONFIG.backup"
fi
ln -s "$PWD/nixpkgs/$DARWIN_CONFIG" "$HOME_DARWIN_CONFIG"

FIREFOX="firefox.nix"
HOME_FIREFOX="$HOME/.nixpkgs/$FIREFOX"
if [ -e "$HOME_FIREFOX" ]
  then cp -r "$HOME_FIREFOX" "$HOME_FIREFOX.backup"
fi
ln -s "$PWD/nixpkgs/$FIREFOX" "$HOME_FIREFOX"

# Link Fish
FISH_FUNCTIONS_INIT="functions"
HOME_FISH_FUNCTIONS="$HOME/.config/fish/$FISH_FUNCTIONS_INIT"
if [ -e "$HOME_FISH_FUNCTIONS" ]
  then cp -r "$HOME_FISH_FUNCTIONS" "$HOME_FISH_FUNCTIONS.backup"
fi
ln -s "$PWD/fish/$FISH_FUNCTIONS_INIT" $HOME_FISH_FUNCTIONS

# Link Neovim
NVIM_INIT="init.vim"
HOME_NVIM="$HOME/.config/nvim/$NVIM_INIT"
if [ -e "$HOME_NVIM" ]
  then cp -r "$HOME_NVIM" "$HOME_NVIM.backup"
fi
ln -s "$PWD/nvim/$NVIM_INIT" $HOME_NVIM

# Link Kitty
KITTY_INIT="kitty.conf"
HOME_KITTY="$HOME/.config/kitty/$KITTY_INIT"
if [ -e "$HOME_KITTY" ]
  then cp -r "$HOME_KITTY" "$HOME_KITTY.backup"
fi
ln -s "$PWD/kitty/$KITTY_INIT" $HOME_KITTY

KITTY_WORKSPACES="workspaces"
HOME_KITTY_WORKSPACES="$HOME/.config/kitty/$KITTY_WORKSPACES"
if [ -e "$HOME_KITTY_WORKSPACES" ]
  then cp -r "$HOME_KITTY_WORKSPACES" "$HOME_KITTY_WORKSPACES.backup"
fi
ln -s "$PWD/kitty/$KITTY_WORKSPACES" $HOME_KITTY_WORKSPACES
