# Dotfiles

This my [nix](https://nixos.org/nix/https://nixos.org/nix/) and [home manager](https://github.com/rycee/home-manager) configuration. This setup assumes you're on MacOS Catalina.

## Usage

First, setup the `/nix` directory by following [these instructions](https://github.com/NixOS/nix/issues/2925#issuecomment-604501661). I went with "Solution 1", and it's worked well for me so far.

Second, [install nix](https://nixos.org/download.html) as a single user (I could not get multi user installation to work):

```
curl -L https://nixos.org/nix/install | sh
```

Then, make sure that `nix` is available on your path and working properly.

Third, [install home manager](https://github.com/rycee/home-manager#installation) :

```
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

Fourth, create symlinks from this directory to `.config`:

```
export DOTFILES=wherever/you/cloned/this/repo

cp -r $HOME/.config/nixpkgs $HOME/.config/nixpkgs_backup
ln -s $DOTFILES/nixpkgs $HOME/.config/nixpkgs
rm -r $HOME/.config/nixpkgs $HOME/.config/nixpkgs_backup

mkdir $HOME/.config/nvim
ln -s $DOTFILES/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json
```

Fifth, create a new home manager generation:

```
home-manager switch
```

Sixth, make fish the default shell:

```
cp -r /usr/local/bin/fish $HOME/.nix-profile/bin/fish
chsh -s /usr/local/bin/fish
```
