#!/bin/sh

PWD=`pwd`

FLAKE_CONFIG="flake.nix"
HOME_FLAKE_CONFIG="/etc/nixos/$FLAKE_CONFIG"
sudo ln -sf "$PWD/$FLAKE_CONFIG" "$HOME_FLAKE_CONFIG"

# Link Fish
mkdir -p "$HOME/.config/fish"
FISH_FUNCTIONS_INIT="functions"
HOME_FISH_FUNCTIONS="$HOME/.config/fish/$FISH_FUNCTIONS_INIT"
ln -sf "$PWD/fish/$FISH_FUNCTIONS_INIT" $HOME_FISH_FUNCTIONS
rm -f "$PWD/fish/functions/functions"

# Link Starship
STARSHIP_INIT="starship.toml"
HOME_STARSHIP="$HOME/.config/$STARSHIP_INIT"
ln -sf "$PWD/starship/$STARSHIP_INIT" $HOME_STARSHIP

# Link scripts
ln -sf "$PWD/scripts/bsc-fmt" "$HOME/.local/bin/bsc-fmt"

# Link git
GIT_CONFIG="gitconfig"
HOME_GIT_CONFIG="$HOME/.$GIT_CONFIG"
ln -sf "$PWD/git/$GIT_CONFIG" "$HOME_GIT_CONFIG"

# Link Kakoune
mkdir -p "$HOME/.config/kak"
KAK_INIT="kakrc"
HOME_KAK="$HOME/.config/kak/$KAK_INIT"
ln -sf "$PWD/kak/$KAK_INIT" $HOME_KAK

# Link kakship
KAK_STARSHIP_INIT="starship.toml"
KAK_HOME_STARSHIP="$HOME/.config/kak/$KAK_STARSHIP_INIT"
ln -sf "$PWD/kak/$KAK_STARSHIP_INIT" $KAK_HOME_STARSHIP

# Link Kakoune-lsp
mkdir -p "$HOME/.config/kak-lsp"
KAK_LSP="kak-lsp.toml"
HOME_KAK_LSP="$HOME/.config/kak-lsp/$KAK_LSP"
ln -sf "$PWD/kak-lsp/$KAK_LSP" $HOME_KAK_LSP

# Link home tab.yml
HOME_TAB="$HOME/.config/tab.yml"
ln -sf "$PWD/home-tab.yml" $HOME_TAB
