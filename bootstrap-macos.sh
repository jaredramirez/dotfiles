#!/bin/sh

PWD=`pwd`

# Link nix-darwin
mkdir -p "$HOME/.config/nixpkgs"
DARWIN_CONFIG="configuration.nix"
HOME_DARWIN_CONFIG="$HOME/.nixpkgs/darwin-configuration.nix"
ln -sf "$PWD/nix/darwin/$DARWIN_CONFIG" "$HOME_DARWIN_CONFIG"

NIX_EXTRAS="extras"
HOME_NIX_EXTRAS="$HOME/.nixpkgs/$NIX_EXTRAS"
ln -sf "$PWD/nixpkgs/$NIX_EXTRAS" "$HOME_NIX_EXTRAS"

# Link Fish
mkdir -p "$HOME/.config/fish"
HOME_FISH_FUNCTIONS="$HOME/.config/fish/functions"
ln -sf "$PWD/fish/functions" $HOME_FISH_FUNCTIONS

# Link Neovim
mkdir -p "$HOME/.config/fish"
NVIM_INIT="init.vim"
HOME_NVIM="$HOME/.config/nvim/$NVIM_INIT"
ln -sf "$PWD/nvim/$NVIM_INIT" $HOME_NVIM

# Link Kitty
mkdir -p "$HOME/.config/kitty"
KITTY_INIT="kitty.conf"
HOME_KITTY="$HOME/.config/kitty/$KITTY_INIT"
ln -sf "$PWD/kitty/$KITTY_INIT" $HOME_KITTY

ln -sf "$PWD/kitty/workspaces" "$HOME/.config/kitty/workspaces"
ln -sf "$PWD/kitty/themes" "$HOME/.config/kitty/themes"

# Link Starship
STARSHIP_INIT="starship.toml"
HOME_STARSHIP="$HOME/.config/$STARSHIP_INIT"
ln -sf "$PWD/starship/$STARSHIP_INIT" $HOME_STARSHIP

# Link nix-direnv
DIRENV_CONFIG="direnvrc"
HOME_DIRENV_CONFIG="$HOME/.$DIRENV_CONFIG"
ln -sf "$PWD/direnv/$DIRENV_CONFIG" "$HOME_DIRENV_CONFIG"

# Link git
GIT_CONFIG="gitconfig"
HOME_GIT_CONFIG="$HOME/.$GIT_CONFIG"
ln -sf "$PWD/git/$GIT_CONFIG" "$HOME_GIT_CONFIG"
