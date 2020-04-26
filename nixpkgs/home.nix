{ config, lib, pkgs, ... }:

{
  home.packages = [
    # DB/Languages
    pkgs.postgresql
    pkgs.python
    pkgs.python3
    pkgs.ruby

    # Helpful Tools
    pkgs.gitAndTools.gh
    pkgs.nix-prefetch-git
    pkgs.amber
    pkgs.heroku

    # Terminal
    pkgs.starship
    pkgs.oh-my-zsh

    # JS
    (pkgs.yarn.override { nodejs = null; })
    pkgs.nodePackages.prettier

    # Elm
    pkgs.elmPackages.elm
    pkgs.elmPackages.elm-format
    pkgs.elmPackages.elm-language-server
    pkgs.elmPackages.elm-analyse
    pkgs.elmPackages.elm-live

    # Reason
    # reason-language-server installed via Coc

    # Haskell
    pkgs.stack
    pkgs.ormolu
    pkgs.ghcid
    (import
      (builtins.fetchTarball "https://github.com/cachix/ghcide-nix/tarball/master")
      {}
    ).ghcide-ghc865

    # Rust
    pkgs.rustup

    # Extras
    pkgs.expect
    pkgs.terminal-notifier
  ];

  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "Jared Ramirez";
      userEmail = "jaredramirez@me.com";
    };

    fish = {
      enable = true;
      functions = {
        nvim_update = ''
          nvim +PlugInstall +UpdateRemotePlugins +qa
        '';
        prefetch_git = ''
          nix-prefetch-git argv[1] --rev argv[2]
        '';
        nvm = ''
          bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
        '';
        nvm_find_nvmrc = ''
          bass source ~/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc
        '';
        load_nvm = {
          onVariable = "PWD";
          body = ''
            set -l default_node_version (nvm version default)
            set -l node_version (nvm version)
            set -l nvmrc_path (nvm_find_nvmrc)

            if test -n "$nvmrc_path"
              set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
              if test "$nvmrc_node_version" = "N/A"
                nvm install $nvmrc_node_version
              else if test nvmrc_node_version != node_version
                nvm use $nvmrc_node_version
              end
            else if test "$node_version" != "$default_node_version"
              echo "Reverting to default Node version"
              nvm use default
            end
          '';
        };
      };
      shellInit = ''
        # Set global variables
        set -x EDITOR nvim
        set -x LANG "en_US.UTF-8"
        set -x TERM "xterm-256color"
        set -x DOTFILES "$HOME/dev/github.com/jaredramirez/dotfiles"
        set -x ANDROID_HOME "$HOME/Library/Android/sdk"
        set -x ANDROID_SDK_ROOT "$HOME/Library/Android/sdk"
        set -x PATH "$ANDROID_HOME/tools/bin" $PATH
        set -x PATH "$ANDROID_HOME/platform-tools" $PATH

        # Load Nix
        bass source /Users/jaredramirez/.nix-profile/etc/profile.d/nix.sh

        # Configure Prompt
        set -x STARSHIP_CONFIG "$HOME/.config/fish/starship.toml"
        starship init fish | source

        # Vi Mode
        set -g fish_key_bindings fish_vi_key_bindings
        bind -M insert \cc kill-whole-line force-repaint

        # Load NVM
        load_nvm

        # Update nvm
        nvim_update
      '';
      shellAbbrs = {
        work = "source $DOTFILES/kitty/sessions/work-sessions.fish";
      };
      plugins = [
        {
          name = "bass";
          src = pkgs.fetchFromGitHub {
            owner = "edc";
            repo = "bass";
            rev = "ba6bee1e859d6f1f912afd01af501df57566f73f";
            sha256 = "0vqj9pqbsww31avrld3l6in4bm330jccwzx4kxw6szmi70b4mvxj";
          };
        }
      ];
    };

    neovim = {
      enable = true;
      extraConfig = ''
        " ------ PLUGINS ------
        if empty(glob('~/.config/nvim/autoload/plug.vim'))
          silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
          autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
        endif

        call plug#begin('~/.config/nvim/bundle')

        " Navigation
        Plug 'ctrlpvim/ctrlp.vim'
        Plug 'sjbach/lusty'

        " Code formatting
        Plug 'sbdchd/neoformat'

        " Tmux
        Plug 'edkolev/tmuxline.vim'
        Plug 'christoomey/vim-tmux-navigator'

        " Language Tooling (COC & others)
        Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}

        " Snips
        Plug 'honza/vim-snippets'

        " Fuzzy finder - also used in the language server complemention menu
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

        " Git
        Plug 'itchyny/vim-gitbranch'
        Plug 'airblade/vim-gitgutter'


        " Status line
        Plug 'itchyny/lightline.vim'

        " Syntax highlighting / themes
        Plug 'altercation/vim-colors-solarized'
        Plug 'sheerun/vim-polyglot'
        Plug 'luochen1990/rainbow'
        Plug 'Yggdroot/indentLine'
        Plug 'itchyny/landscape.vim'

        " Other syntax highlighting
        " for the (few) languages not supported by polyglot
        " or for polygot packages that I dislike
        Plug 'reasonml-editor/vim-reason-plus'
        Plug 'andys8/vim-elm-syntax'
        Plug 'milch/vim-fastlane'
        Plug 'Quramy/vim-js-pretty-template'

        " For Wakatime -> https://kapeli.com/dash
        Plug 'wakatime/vim-wakatime'
        " For Ack -> https://beyondgrep.com/
        Plug 'mileszs/ack.vim'

        " Code Commenter
        Plug 'scrooloose/nerdcommenter'

        " Defaults
        Plug 'tpope/vim-sensible'
        Plug 'easymotion/vim-easymotion'
        Plug 'ap/vim-css-color'

        call plug#end()

        " ------ GENERAL CONFIG ------

        " Disable compatabliltiy with vi
        set nocompatible

        " Hide buffer instead of abandoning when switching
        set hidden

        " Set max line length for JS/TS
        autocmd BufRead,BufNewFile *.js,*jsx,*.ts,*.tsx setlocal colorcolumn=80


        " Show invisibles
        set list listchars=tab:··,trail:·,nbsp:·,eol:¬

        " Enable syntax highlighting
        syntax enable


        " Enable file specific behavior like syntax highlighting and indentation
        filetype on
        filetype plugin on
        filetype indent on

        " Use system clipboard
        set clipboard=unnamed

        " Disable toolbar
        set guioptions=F

        " Search options
        set ignorecase
        set smartcase

        " No sounds
        set visualbell
        set noerrorbells

        " Set tabs in general and for specific file types
        set tabstop=2
        set shiftwidth=2
        set expandtab
        autocmd FileType elm,java setlocal tabstop=4 shiftwidth=4

        " Set theme colors
        let s:red = '#d3423a'
        let s:yellow = '#ffcb8b'
        let s:green = '#addb67'
        let s:cyan = '#7fdbca'
        let s:blue = '#82aaff'
        let s:magenta = '#c792ea'
        let s:background = '#0e293f'
        let s:foreground = '#d6deeb'

        " Color/Theme with custom overrides
        if (has("termguicolors"))
         set termguicolors
        endif

        set background=dark
        " set background=light
        colorscheme solarized
        highlight Comment gui=italic cterm=italic
        highlight Todo ctermfg=222 guifg=s:yellow guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
        highlight Error guifg=s:red ctermfg=204 guibg=NONE ctermbg=NONE


        " Set view attributes
        set number
        set ruler
        set cursorline

        " Make <Shift><K> insert a new line at the cursor
        nnoremap K i<CR><Esc>

        " Set Leader
        let mapleader="\<SPACE>"

        " Disabled Ctrl-C
        inoremap <C-c> <Nop>

        " Keep cursor in the center of the screen
        set scrolloff=999

        " Disable cursor flash
        set guicursor=a:blinkon0

        " Set persistant undo
        set undofile
        set undodir=~/.config/nvim/undodir

        " Set file plum
        " If not running neovim 0.4.x, comment out this section
        set wildoptions=pum
        set pumblend=10

        " Autoreload files after they change on disk
        autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
        autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

        " Open preview window at the bottom of the screen
        set splitbelow

        " Enable project level config (.nvimrc)
        set exrc
        set secure


        " ------ PLUGIN CONFIG ------

        " Configure Ctrl-P

        " Open Ctrl-P
        nnoremap <Leader>o :CtrlP<CR>
        " Open Ctrl-P buffer
        nnoremap <Leader>b :CtrlPBuffer<CR>
        " Ctrl-P ignores
        set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/deps/*,*/_build/*,*/dist/*,*/build/*,*/legacy/*,*/elm-stuff/*
        " Disable ctrl-p cache so it can easily detect new files
        let g:ctrlp_use_caching = 0

        " Configure syntax both vim-polygot & others
        let g:polyglot_disabled = ['reason', 'elm']
        let g:javascript_plugin_flow = 1

        autocmd FileType javascript syn clear javascriptTemplate
        autocmd FileType javascript.jsx syn clear javascriptTemplate
        call jspretmpl#register_tag('gql', 'graphql')
        autocmd FileType javascript JsPreTmpl
        autocmd FileType javascript.jsx JsPreTmpl


        " Configure rainbow parentheses
        let g:rainbow_active = 0
        let g:rainbow_conf = {
          \ 'guifgs': ['#5FD7FF', '#FFFFAF', '#AFFFFF', '#FFD7FF'],
          \ 'ctermfgs': ['51', '229', '159', '225'],
          \ 'parentheses': [
            \ 'start=/(/ end=/)/ fold',
            \ 'start=/\[/ end=/\]/ fold',
            \ 'start=/{\(-|\)\@!/ end=/\(-\)\@<!}/ fold'
          \],
        \}

        " Configure NERD Commenter
        let g:NERDSpaceDelims = 1

        " Configure light line

        function! FilenameAndParentDir()
          return expand('%:p:h:t') . '/' . expand('%:t')
        endfunction

        let g:lightline = {
          \ 'colorscheme': 'solarized',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'gitbranch', 'readonly', 'fileAndParentDir', 'modified' ] ],
          \   'right': [ [ 'lineinfo' ],
          \              [ 'percent' ],
          \              [ 'cocstatus', 'fileencoding', 'filetype' ]
          \            ]
          \ },
          \ 'component_function': {
          \   'gitbranch': 'gitbranch#name',
          \   'cocstatus': 'coc#status',
          \   'fileAndParentDir': 'FilenameAndParentDir'
          \ },
          \ 'separator': { 'left': '', 'right': '' },
          \ 'subseparator': { 'left': '', 'right': '' },
          \ }


        " Configure Neoformat
        augroup fmt
          autocmd!
          autocmd BufWritePre * Neoformat
        augroup END

        " Configure auto-formatters
        let g:neoformat_enabled_javascript = ['prettier']
        let g:neoformat_enabled_haskell = ['ormolu']
        let g:neoformat_enabled_elm = ['elmformat']
        let g:neoformat_enabled_reason = ['refmt']
        let g:neoformat_try_formatprg = 1
        let g:neoformat_run_all_formatters = 1
        let g:neoformat_basic_format_retab = 1
        let g:neoformat_basic_format_trim = 1

        " Configure indentLine
        let g:indentLine_char = '▏'

        set updatetime=300
        set shortmess+=c
        set signcolumn=yes
        set completeopt=noinsert,menuone,noselect

        " Setup autocomplete/snippets menu
        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

        " Coc
        let g:coc_global_extensions = [
          \ 'coc-syntax',
          \ 'coc-css',
          \ 'coc-flow',
          \ 'coc-html',
          \ 'coc-reason',
          \ 'coc-rls',
          \ 'coc-snippets'
        \ ]

        inoremap <silent><expr> <cr>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump',' ']) :
            \  "\<C-g>u\<CR>"

        let g:coc_snippet_next = '<Tab>'
        let g:coc_snippet_prev = '<S-Tab>'
        imap <C-j> <Plug>(coc-snippets-expand-jump)

        " Highlight symbol under cursor on CursorHold
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Highlights in general
        highlight CocUnderline guifg=#ff5874 ctermfg=204 guibg=NONE ctermbg=NONE
        highlight CocErrorSign guifg=#000000 ctermfg=0 guibg=NONE ctermbg=NONE
        highlight CocHighlightText guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE
        highlight link CocWarningHighlight CocInfoSign
        highlight link CocHintHighlight CocHintSign
        highlight link CocWarningFloat CocErrorFloat
        highlight link CocInfoFloat CocErrorFloat
        highlight link CocHintFloat CocErrorFloat

        " Mapings
        nnoremap gh :call <SID>show_documentation()<CR>
        nnoremap gr <Plug>(coc-rename)

        function! s:show_documentation()
          if &filetype == 'vim'
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        " Configure Git Gutter
        highlight GitGutterAdd ctermfg=149 ctermbg=NONE guifg=#addb67 guibg=NONE
        highlight GitGutterChange ctermfg=116 ctermbg=NONE guifg=#011627 guibg=NONE
        highlight GitGutterDelete ctermfg=204 ctermbg=NONE guifg=#ff5874 guibg=NONE
      '';
    };

    kitty = {
      enable = true;
      font = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };
      keybindings = {
        "ctrl+a>n" = "next_tab";
        "ctrl+a>p" = "previous_tab";
        "ctrl+a>c" = "new_tab";
        "ctrl+a>r" = "set_tab_title";
        "ctrl+a>q" = "close_tab";
        "ctrl+a>1" = "goto_tab 1";
        "ctrl+a>2" = "goto_tab 2";
        "ctrl+a>3" = "goto_tab 3";
        "ctrl+a>4" = "goto_tab 4";
        "ctrl+a>5" = "goto_tab 5";
        "ctrl+a>6" = "goto_tab 6";
        "ctrl+a>7" = "goto_tab 7";
        "ctrl+a>8" = "goto_tab 8";
        "ctrl+a>9" = "goto_tab 9";
        "ctrl+a>u" = "scroll_page_up";
        "ctrl+a>d" = "scroll_page_down";
        "ctrl+a>w" = "new_window_with_cwd";
        "ctrl+a>x" = "close_window";
        "ctrl+l" = "neighboring_window right";
        "ctrl+h" = "neighboring_window left";
        "ctrl+k" = "neighboring_window top";
        "ctrl+j" = "neighboring_window bottom";
        "ctrl+a>m" = "next_layout";
        "ctrl+a>b" = "start_resizing_window";
        "ctrl+a>i" = "prev_window";
        "ctrl+a>o" = "next_window";
        "cmd+c" = "copy_to_clipboard";
        "ctrl+v" = "paste_from_clipboard";
      };
      settings =
        let
          solarizedLight = {
            background = "#fdf6e3";
            foreground = "#52676f";
            cursor = "#52676f";
            color0 = "#e4e4e4";
            color8 = "#002b36";
            color1 = "#d70000";
            color9 = "#d75f00";
            color2 = "#5f8700";
            color10 = "#585858";
            color3 = "#af8700";
            color11 = "#626262";
            color4 = "#0087ff";
            color12 = "#808080";
            color5 = "#af005f";
            color13 = "#5f5faf";
            color6 = "#00afaf";
            color14 = "#8a8a8a";
            color7 = "#262626";
            color15 = "#1c1c1c";
            selection_background = "#e9e2cb";
            selection_foreground = "#fcf4dc";
            inactive_tab_foreground = "#fdf6e3";
            inactive_tab_background = "#586e75";
            active_tab_foreground  = "#fdf6e3";
            active_tab_background  = "#839496";
          };
          solarizedDark = {
            background = "#001e26";
            foreground = "#9bc1c2";
            cursor = "#f34a00";
            color0 = "#002731";
            color8 = "#006388";
            color1 = "#d01b24";
            color9 = "#f4153b";
            color2 = "#6bbe6c";
            color10 = "#50ee84";
            color3 = "#a57705";
            color11 = "#b17e28";
            color4 = "#2075c7";
            color12 = "#178dc7";
            color5 = "#c61b6e";
            color13 = "#e14d8e";
            color6 = "#259185";
            color14 = "#00b29e";
            color7 = "#e9e2cb";
            color15= "#fcf4dc";
            selection_background  = "#003747";
            selection_foreground = "#001e26";
            inactive_tab_foreground = "#001e26";
            inactive_tab_background = "#657b83";
            active_tab_foreground = "#001e26";
            active_tab_background = "#93a1a1";
          };
        in
        solarizedDark //
          {
            font_size = 20;
            enabled_layouts = "stack, horizontal, splits";
            tab_bar_style = "powerline";
            cursor_blink_interval = 0;
            macos_quit_when_last_window_closed = true;
            macos_thicken_font = "0.75";
            macos_custom_beam_cursor = true;
            allow_remote_control = true;
            enable_audio_bell = false;
          };
    };

    bat = {
      enable = true;
    };

    # TODO: Finish configuring Firefox
    # firefox = {
      # enable = true;
      # extensions =
        # with pkgs.nur.repos.rycee.firefox-addons; [
          # https-everywhere
          # dashlane
        # ];
    # };
  };

  home.stateVersion = "20.03";
}
