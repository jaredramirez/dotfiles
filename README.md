# env

This is the configuration I use for Neovim, Kitty, and ZSH.

Whatever font you use must include powerline symbols! I use [Fira Code](https://github.com/tonsky/FiraCode), it's free and really nice.

## Usage

### Neovim (Text Editor)

There are a few things to install before getting started:

* [`neovim`](https://neovim.io/)
* [`vim-plug`](h-tps://github.com/junegunn/vim-plug) - This will install automatically the first time you launch neovim with the `init.vim` provided in this repo
* [`yarn`](https://yarnpkg.com/lang/en/) - This is necessary for [`vim-prettier`](https://github.com/prettier/vim-prettier), if you don't want to install yarn then just remove that plugin from `nvim/init.vim`

After that, symlink `nvim/init.vim` to `~/.config/nvim/init.vim`.

Once these prereqs installed & `init.vim` is symlinked, run `nvim +PlugInstall +UpdateRemotePlugins +qa` to install the vim plugins used.

I prefer to use langauge servers, rather than linters, for each language that I work in. I've included links to each one I use here. You'll need to install each language server for each lanuage that you want.

```
" For Haskell langauge server -> https://github.com/haskell/haskell-ide-engine
" For Rust langauge server -> https://github.com/rust-lang-nursery/rls
" For Ocamel/Reason language server -> https://github.com/freebroccolo/ocaml-language-server<Paste>
" For Flow(JS) language server -> https://github.com/flowtype/flow-language-server
" For Typescript language server -> https://github.com/sourcegraph/javascript-typescript-langserver
```

These links can also be found in `nvim/init.vim`.

I also like to use code formatters. You'll need to install each formatter for each lanuage that you want. The list of the ones that I use is here:

```
" For ReasonML formatting -> https://github.com/reasonml/reason-cli
" For Elm formatting -> https://github.com/avh4/elm-format
" For Rust formatting -> https://github.com/rust-lang-nursery/rustfmt
" For Haskell formatting -> https://www.google.com/search?q=hfmt&ie=utf-8&oe=utf-8&client=firefox-b-1-ab
```

These can also be found in `nvim/init.vim`.

You're done with Neovim config!

### ZSH (Shell)

There are a few things to install before getting started:

* [`zsh`](http://zsh.sourceforge.net/)
* [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh#basic-installation)
* [`spaceship-prompt`](https://github.com/denysdovhan/spaceship-prompt#oh-my-zsh)
* [`hub`](bas://hub.github.com/) - This is optional (I find it helpful though). If you don't want to use it, you'll need to remove a line 32 in `zsh/.zshrc`

After that, symlink `zsh/zshenv` to `~/.zshenv`.
After that, symlink `zsh/zshrc` to `~/.zshrc`.
Then, symlink `zsh/scripts/helpers.sh` to `~/scripts/helpers.sh`. This is a group of random scripts that I use to run various tings. If you want to exclude this, then you'll need to remove line 26 in `zsh/.zshrc`

You're done with ZSH config!

### Kitty (Teminal Emulator)

There are a few things to install before getting started:

* [`kitty`](https://sw.kovidgoyal.net/kitty/)

After that, symlink `kitty/kitty.conf` to `~/.config/kitty/kitty.conf`.
After that, update line 43 in `zsh/zshenv` to point to `./kitty` (wherever you cloned this project)

Please note that the kitty config set the emulator's font to [Fira Code](https://github.com/tonsky/FiraCode). You can change your font to whatever you want, but you will have to update `kitty/kitty.conf` to the other font.

I have my Kitty keybindings setup to mirror tmux's keybindings (since I used that before kitty). The
prefix I use is `ctrl+a>KEY`, so if you don't like that then you'll have to change that. For the full list of
keybindings take a look at `kitty/kitty.conf`

If you use OSX, and want Kitty to open automatically in full screen mode, follow the directions [here](https://stackoverflow.com/a/32405815/8838731), to expose your `$PATH` to gui applications. If you don't want this, then feel free to ignore this.

You're done with Kitty config!
