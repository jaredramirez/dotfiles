# env

This is the configuration I use for neovim and tmux

## Usage

### Neovim

There are a few things to install before getting started:

* [`neovim`](https://neovim.io/) (Of course)
* [`vim-plug`](https://github.com/junegunn/vim-plug)
* `yarn` (This is necessary for [`vim-prettier`](https://github.com/prettier/vim-prettier), if you don't want to install yarn then just remove that plugin from `nvim/init.vim`)

Once these are installed & working, you can copy the `nvim` directory to `~/.config/nvim`. Then run `nvim +PlugInstall +UpdateRemotePlugins +qa`.

I prefer to use langauge servers, rather than linters, for each language that I work in. I've included links to each one I use here:

```
" For Haskell langauge server -> https://github.com/haskell/haskell-ide-engine
" For Rust langauge server -> https://github.com/rust-lang-nursery/rls
" For Ocamel/Reason language server -> https://github.com/freebroccolo/ocaml-language-server<Paste>
" For Flow(JS) language server -> https://github.com/flowtype/flow-language-server
" For Typescript language server -> https://github.com/sourcegraph/javascript-typescript-langserver
```

These links can also be found in `nvim/init.vim`.

I also like to use code formatters. The list of the ones that I use is here:

```
" For ReasonML formatting -> https://github.com/reasonml/reason-cli
" For Elm formatting -> https://github.com/avh4/elm-format
" For Rust formatting -> https://github.com/rust-lang-nursery/rustfmt
" For Haskell formatting -> https://www.google.com/search?q=hfmt&ie=utf-8&oe=utf-8&client=firefox-b-1-ab
```

These can also be found in `nvim/init.vim`.

You're done with Neovim config!

### Tmux

My usage of Tmux is much simpler than my usage of Neovim. Here's how to get setup.

There are a few things to install before getting started:

* `tmux` (Of course)
* [`tmux-plugin-manager`](https://github.com/tmux-plugins/tpm)
* `python3`

After that, copy `tmux/.tmux.conf` to `~`. You'll need to update `tmux/.tmux.conf` on line 34 with the path to your python3 installation. Then run `prefix`(C-A) + `I` to install the plugins.

You're done with Tmux config!
