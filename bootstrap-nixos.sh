#!/bin/sh

PWD=`pwd`

# Link nixos configuration
NIXOS_CONFIG="configuration.nix"
HOME_NIXOS_CONFIG="/etc/nixos/$NIXOS_CONFIG"
sudo ln -sf "$PWD/nix/nixos/$NIXOS_CONFIG" "$HOME_NIXOS_CONFIG"

# Link Fish
mkdir -p "$HOME/.config/fish"
FISH_FUNCTIONS_INIT="functions"
HOME_FISH_FUNCTIONS="$HOME/.config/fish/$FISH_FUNCTIONS_INIT"
ln -sf "$PWD/fish/$FISH_FUNCTIONS_INIT" $HOME_FISH_FUNCTIONS

# Link Neovim
mkdir -p "$HOME/.config/nvim"
NVIM_INIT="init.vim"
HOME_NVIM="$HOME/.config/nvim/$NVIM_INIT"
ln -sf "$PWD/nvim/$NVIM_INIT" $HOME_NVIM

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
