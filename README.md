# env

This is the configuration I use for Neovim, Kitty, and ZSH.

Whatever font you use must include powerline symbols! I use [Fira Code](https://github.com/tonsky/FiraCode), it's free and really nice.

## Usage

### Neovim (Text Editor)

There are a few things to install before getting started:

* [`neovim`](https://neovim.io/)
* [`vim-plug`](h-tps://github.com/junegunn/vim-plug) - This will install automatically the first time you launch neovim with the `init.vim` provided in this repo
* [`yarn`](https://yarnpkg.com/lang/en/)

After that, symlink `nvim/init.vim` to `~/.config/nvim/init.vim`.
After that, symlink `nvim/coc-settings.json` to `~/.config/nvim/coc-settings.json`.

Once these prereqs installed & `init.vim` is symlinked, run `nvim +PlugInstall` to install the vim plugins used.

I prefer to use langauge servers, rather than linters, for each language that I work in. I've included links to each one I use here. You'll need to install each language server for each lanuage that you want.

```
" For Haskell langauge server -> https://github.com/haskell/haskell-ide-engine
" For Flow(JS) language server -> https://github.com/facebook/flow
```

The language server that I use is [Coc](https://github.com/neoclide/coc.nvim) , which also uses extensions to improve editing expereince.
To install the extensions that I use, run the following inside neovim. You can look at a whole list of
coc extensions [here](https://www.npmjs.com/search?q=keywords%3Acoc.nvim)
```run
:CocInstall coc-pairs coc-snippets coc-java coc-json coc-html coc-syntax coc-css
```

I also like to use code formatters. You'll need to install each formatter for each language that you want.
The list of the ones that I use is here:

```
" For Elm formatting -> https://github.com/avh4/elm-format
" For Haskell formatting -> https://www.google.com/search?q=hfmt&ie=utf-8&oe=utf-8&client=firefox-b-1-ab
```

You're done with Neovim config!

### ZSH (Shell)

There are a few things to install before getting started:

* [`zsh`](http://zsh.sourceforge.net/)
* [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh#basic-installation)
* [`spaceship-prompt`](https://github.com/denysdovhan/spaceship-prompt#oh-my-zsh)
* [`hub`](bas://hub.github.com/) - This is optional (I find it helpful though). If you don't want to use it, you'll need to remove a line 32 in `zsh/.zshrc`

After that, symlink `zsh/zshenv` to `~/.zshenv`.
After that, symlink `zsh/zshrc` to `~/.zshrc`.
Then, symlink `zsh/scripts/helpers.sh` to `~/scripts/helpers.sh`. This is a group of random scripts that I use to run various tings.
If you want to exclude this, then you'll need to remove line 26 in `zsh/.zshrc`

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

Also, you can setup custom window layouts with kitty. Take a look at `kitty/session` for the layout/window config.
You'll definitely want to change those to the sessions that you use for work/school/hobby. I alias the setup commands in `zsh/zshrc`.

You're done with Kitty config!
