#!/bin/sh

PWD=`pwd`

# Link nix-darwin
mkdir -p "$HOME/.config/darwin"
FLAKE_CONFIG="flake.nix"
HOME_FLAKE_CONFIG="$HOME/.config/darwin/flake.nix"
ln -sf "$PWD/$FLAKE_CONFIG" "$HOME_FLAKE_CONFIG"

# Link Fish
mkdir -p "$HOME/.config/fish"
HOME_FISH_FUNCTIONS="$HOME/.config/fish/functions"
ln -sFf "$PWD/fish/functions" $HOME_FISH_FUNCTIONS
rm -f "$PWD/fish/functions/functions"

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

# Link Alacritty
mkdir -p "$HOME/.config/alacritty"
ALACRITTY_INIT="alacritty.yml"
HOME_ALACRITTY="$HOME/.config/alacritty/$ALACRITTY_INIT"
ln -sf "$PWD/alacritty/$ALACRITTY_INIT" $HOME_ALACRITTY

# Link Kakoune
mkdir -p "$HOME/.config/kak"
KAK_INIT="kakrc"
HOME_KAK="$HOME/.config/kak/$KAK_INIT"
ln -sf "$PWD/kak/$KAK_INIT" $HOME_KAK

# Link Kakoune-lsp
mkdir -p "$HOME/.config/kak-lsp"
KAK_LSP="kak-lsp.toml"
HOME_KAK_LSP="$HOME/.config/kak-lsp/$KAK_LSP"
ln -sf "$PWD/kak-lsp/$KAK_LSP" $HOME_KAK_LSP

# Link home tab.yml
HOME_TAB="$HOME/.config/tab.yml"
ln -sf "$PWD/home-tab.yml" $HOME_TAB
