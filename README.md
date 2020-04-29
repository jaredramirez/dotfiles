# Dotfiles

This my [nix](https://nixos.org/nix/https://nixos.org/nix/) and [home manager](https://github.com/rycee/home-manager) configuration. This setup assumes you're on MacOS Catalina.

## Setup in 10 steps

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
```

Fifth, update `DOTFILES` in `programs.fish.shellInit` in `$DOTFILES/nixpkgs/home.nix` to `"wherever/you/cloned/this/repo"`.

Sixth, install [fnm](https://github.com/Schniz/fnm) with the following command (unfortunaly not available on nixpkgs):

```
curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash -s --install-dir "$HOME/.fnm" --skip-shell
```

Seventh, create a new home manager generation:

```
home-manager switch
```

Eighth, update `$DOTFILES/kitty/sessions/work-sessions.fish` with commands to open up your work directories and what not. Later, you can call `work` and it'll run that file. Checkout [kitty's documentation](https://sw.kovidgoyal.net/kitty/index.html#startup-sessions) for more examples.

Ninth, make fish the default shell:

```
cp -r /usr/local/bin/fish $HOME/.nix-profile/bin/fish
chsh -s /usr/local/bin/fish
```

Tenth, install Neovim plugins with `update_nvim`

That's it, you should be good to go!
