# env

This is the configuration I use for neovim, soon to add my tmux configuration.

## Usage

There are a few things to install before getting started:

* ['neovim'](https://neovim.io/) (Of course)
* [`yarn`](https://yarnpkg.com/en/)
* [`vim-plug`](https://github.com/junegunn/vim-plug)

Once these are installed & working, you can copy the `nvim` directory to `~/.config/nvim`. Then just run `nvim +PlugInstall` and you should be good to go (almost).

For the haskell language server, navigate here [haskell/haskell-ide-engine](https://github.com/haskell/haskell-ide-engine), and go through their installation process. It's not availabe on NPM, and must be built from source so it could not be included in the post-install hook of LanguageClient-Neovim.
