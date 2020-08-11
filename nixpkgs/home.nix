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
    pkgs.gitAndTools.delta
    pkgs.heroku
    pkgs.nix-prefetch-git
    pkgs.amber
    pkgs.silver-searcher

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
    pkgs.haskell.packages.ghc865.haskell-language-server

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
      extraConfig = {
        core = {
          pager = "delta";
        };
        interactive = {
          diffFilter = "delta --color-only";
        };
      };
    };

    bat = {
      enable = true;
    };

    fish = {
      enable = true;
      functions = {
        prefetch_git = ''
          nix-prefetch-git argv[1] --rev argv[2]
        '';
        symlink = ''
          -- TODO: finish
          if test "$argv[1]" = "--help"
            echo "symlink usage: symlink original link"
          else
            if test (count argv) = 2
              ls -s argv[1] argv[2]
            else
              echo "symlink usage: symlink original link"
            end
          end
        '';
        link_apps = ''
            set -l NIX_PROFILE $HOME/.nix-profile
            set -l APP_DIR $HOME/Applications

            # Remove broken links
            for i in $APP_DIR/*;
                if [ -L "$f" ] && [ ! -e "$f" ];
                    rm $f
                end
            end

            # Link new ones
            for f in $NIX_PROFILE/Applications/*;
                set -l app_name (basename $f)
                if [ ! -e $APP_DIR/$app_name ];
                    ln -s "$f" $APP_DIR/
                end
            end
        '';
        fish_user_key_bindings = ''
          # Vi Mode
          set -g fish_key_bindings fish_vi_key_bindings
          bind -M insert \cc kill-whole-line force-repaint
        '';
        ag_with_ignores = ''
          set -l filter ".jpg" ".bmp" ".png" ".jar" ".7z" ".bz"
          set -l filter $filter ".zip" ".tar" ".gz" ".tgz" ".git"
          if [ -f "bsconfig.json" ];
            set filter $filter "lib" ".bs.js"
          end
          if [ -f "metro.config.js" ] || [ -f "react-native.config.js" ];
            set filter $filter "build" "Pods"
          end
          if [ -f "Cargo.toml" ];
            set filter $filter "target"
          end
          if [ -f "elm.json" ];
            set filter $filter "elm-stuff"
          end
          if [ -f "package.json" ];
            set filter $filter "node_modules" ".min.js"
          end
          if [ -f "package.yaml" ] || [ -f "stack.yaml" ];
            set filter $filter ".stack-work"
          end
          ag --hidden -p (printf "*%s*\n" $filter | psub) -g ""
        '';
        git_branch_cleanup = ''
          git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d
        '';
      };
      shellInit = ''
        # Set global variables
        set -gx EDITOR nvim
        set -gx LANG "en_US.UTF-8"
        set -gx DOTFILES "$HOME/dev/github.com/jaredramirez/dotfiles"
        set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
        set -gx ANDROID_SDK_ROOT "$HOME/Library/Android/sdk"
        set -gx JAVA_HOME "/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
        set -gx SHELL "$HOME/.nix-profile/bin/fish"
        set -gx FZF_DEFAULT_COMMAND "ag_with_ignores"
        set -gx QMK_HOME "$HOME/.qmk_firmware"
        set -gx PATH "$ANDROID_HOME/tools/bin" $PATH
        set -gx PATH "$ANDROID_HOME/platform-tools" $PATH
        set -gx PATH "$HOME/.local/bin" $PATH
        set -gx PATH "$HOME/.fnm" $PATH

        # Load Nix
        bass source /Users/jaredramirez/.nix-profile/etc/profile.d/nix.sh
      '';
      promptInit = ''
        # Load FNM
        fnm env --multi --use-on-cd | source

        set -gx STARSHIP_CONFIG "$HOME/.config/fish/starship.toml"
        starship init fish | source
      '';
      shellAliases = {
        work = "source $DOTFILES/kitty/sessions/work-sessions.fish";
        nvim_update = "nvim +PlugInstall +UpdateRemotePlugins +qa";
        pg_start = "pg_ctl -D $HOME/.config/postgres/data start";
        pg_stop = "pg_ctl -D $HOME/.config/postgres/data stop";
        oni2 = "/Applications/Onivim2.app/Contents/Resources/run.sh";
        reload = "home-manager switch && source ~/.config/fish/config.fish";
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

    alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "MonoLisa";
          };
          bold = {
            family = "MonoLisa Bold";
          };
          italic = {
            family = "MonoLisa Italic";
          };
          bold_italic = {
            family = "MonoLisa Bold Italic";
          };
        };
        colors = {
          primary = {
            background = "0x002b36";
            foreground = "0x839496";
          };
          normal = {
            black = "0x073642";
            red = "0xdc322f";
            green = "0x859900";
            yellow = "0xb58900";
            blue = "0x268bd2";
            magenta ="0xd33682";
            cyan = "0x2aa198";
            white = "0xeee8d5";
          };
          bright = {
            black = "0x002b36";
            red = "0xcb4b16";
            green ="0x586e75";
            yellow = "0x657b83";
            blue = "0x839496";
            magenta ="0x6c71c4";
            cyan = "0x93a1a1";
            white = "0xfdf6e3";
          };
        };
      };
    };

    kitty = {
      enable = true;
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
        "ctrl+a>m" = "next_layout";
        "ctrl+a>b" = "start_resizing_window";
        "ctrl+a>i" = "prev_window";
        "ctrl+a>o" = "next_window";
        "cmd+c" = "copy_to_clipboard";
        "cmd+v" = "paste_from_clipboard";
      };
      settings =
        let
          # From https://github.com/rsaihe/sonokai-kitty
          color_scheme = {
            background = "#2b2d3a";
            foreground = "#e1e3e4";
            cursor = "#e1e3e4";
            selection_background  = "#3a3e4e";
            selection_foreground = "#e1e3e4";
            inactive_tab_font_style = "normal";
            inactive_tab_foreground = "#e1e3e4";
            inactive_tab_background = "#2b2d37";
            active_tab_font_style = "bold";
            active_tab_foreground = "#e1e3e4";
            active_tab_background = "#3F445B";
            color0 = "#181a1c";
            color8 = "#7e8294";
            color1 = "#fb617e";
            color9 = "#fb617e";
            color2 = "#9ed06c";
            color10 = "#9ed06c";
            color3 = "#f0c362";
            color11 = "#f0c362";
            color4 = "#6dcae8";
            color12 = "#6dcae8";
            color5 = "#bb97ee";
            color13 = "#bb97ee";
            color6 = "#f89860";
            color14 = "#f89860";
            color7 = "#e1e3e4";
            color15= "#e1e3e4";
          };
        in
        color_scheme //
          {
            font_family = "MonoLisa";
            font_size = 17;
            # To avoid clashing field names
            font_features = "MonoLisa-Regular -liga";
            "font_features " = "MonoLisa-Bold -liga";
            "font_features  " = "MonoLisa-BoldItalic -liga";
            "font_features   " = "MonoLisa-RegularItalic -liga";
            disable_ligatures = "always";
            enabled_layouts = "stack, horizontal";
            tab_bar_style = "powerline";
            cursor_blink_interval = 0;
            macos_quit_when_last_window_closed = true;
            macos_thicken_font = "0.75";
            macos_custom_beam_cursor = true;
            allow_remote_control = true;
            enable_audio_bell = false;
          };
    };

    neovim = {
      enable = true;
      extraConfig = ''
        " Set shell
        set shell=$HOME/.nix-profile/bin/fish

        " ------ PLUGINS ------
        if empty(glob('~/.config/nvim/autoload/plug.vim'))
          silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
          autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
        endif

        call plug#begin('~/.config/nvim/bundle')

        " Navigation
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'

        " Code formatting
        Plug 'sbdchd/neoformat'

        " Language Tooling (COC & others)
        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        " Snips
        Plug 'honza/vim-snippets'

        " Git
        Plug 'itchyny/vim-gitbranch'
        Plug 'airblade/vim-gitgutter'

        " Status line
        Plug 'itchyny/lightline.vim'

        " Syntax highlighting / themes
        Plug 'sainnhe/sonokai'
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

        " Code Commenter
        Plug 'scrooloose/nerdcommenter'

        " Defaults
        Plug 'tpope/vim-sensible'
        Plug 'easymotion/vim-easymotion'
        Plug 'ap/vim-css-color'
        Plug 'psliwka/vim-smoothie'

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

        " Color/Theme with custom overrides
        if (has("termguicolors"))
         set termguicolors
        endif

        let g:sonokai_style = 'andromeda'
        let g:sonokai_enable_italic = 1
        let g:sonokai_disable_italic_comment = 1

        set background=dark
        colorscheme sonokai

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

        " Disabled Ctrl-C
        inoremap <C-c> <Nop>

        " Clear currently search highlighting
        nnoremap <silent> <esc> :let @/ = ""<return><esc>

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

        " Keep cursor vertically centered
        set scrolloff=999

        " Enable project level config (.nvimrc)
        " set exrc
        " set secure

        " Configure splits
        nnoremap <C-J> <C-W>j
        nnoremap <C-K> <C-W>k
        nnoremap <C-L> <C-W>l
        nnoremap <C-H> <C-W>h
        set splitbelow
        set splitright

        " ------ PLUGIN CONFIG ------

        " Configure vim smoothie
        let g:smoothie_base_speed = 25

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
          \ 'colorscheme': 'sonokai',
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
        let g:neoformat_haskell_ormolu = { 'exe': 'ormolu', 'args': [] }
        let g:neoformat_enabled_haskell = ['ormolu']
        let g:neoformat_enabled_elm = ['elmformat']
        let g:neoformat_enabled_reason = ['refmt']
        let g:neoformat_try_formatprg = 1
        let g:neoformat_run_all_formatters = 1
        let g:neoformat_basic_format_retab = 1
        let g:neoformat_basic_format_trim = 1

        " Configure indentLine
        let g:indentLine_char = '▏'
        set concealcursor+=v

        set updatetime=300
        set shortmess+=c
        set signcolumn=yes
        set completeopt=noinsert,menuone,noselect

        " Setup autocomplete/snippets menu
        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

        " Highlights in general
        highlight SignColumn guibg=NONE ctermbg=NONE
        highlight CocUnderline gui=undercurl term=undercurl
        highlight CocErrorSign guifg=#fb617e ctermfg=0 gui=NONE term=NONE
        highlight CocErrorHighlight guifg=#fb617e ctermfg=0 gui=undercurl term=undercurl
        highlight CocWarningHighlight guifg=#f0c362 ctermfg=0 gui=undercurl term=undercurl
        highlight CocHintHighlight guifg=#6dcae8 ctermfg=0 gui=undercurl term=undercurl
        highlight CocHighlightText guifg=NONE ctermfg=NONE gui=NONE term=NONE


        " Configure Git Gutter
        highlight GitGutterAdd ctermfg=149 ctermbg=NONE guifg=#addb67 guibg=NONE
        highlight GitGutterChange ctermfg=116 ctermbg=NONE guifg=#011627 guibg=NONE
        highlight GitGutterDelete ctermfg=204 ctermbg=NONE guifg=#ff5874 guibg=NONE

        " FZF
        let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Todo', 'border': 'rounded' } }

        " Coc
        let g:coc_node_path = '$HOME/.fnm/aliases/default/bin/node'

        let g:coc_global_extensions = [
          \ 'coc-syntax',
          \ 'coc-css',
          \ 'coc-html',
          \ 'coc-reason',
          \ 'coc-rls',
          \ 'coc-snippets'
        \ ]

        inoremap <silent><expr> <cr>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable()
            \   ? coc#rpc#request('doKeymap', ['snippets-expand-jump',' '])
            \   : "\<C-g>u\<CR>"

        let g:coc_snippet_next = '<Tab>'
        let g:coc_snippet_prev = '<S-Tab>'
        imap <C-j> <Plug>(coc-snippets-expand-jump)

        " Highlight symbol under cursor on CursorHold
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Coc Mapings
        nmap <silent> gh <Plug>(coc-diagnostic-info)
        nmap <silent> gn <Plug>(coc-rename)
        nmap <silent> gi :call CocAction('format')<CR>
        nmap <silent> gy :call <SID>show_documentation()<CR>

        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        " Coc Fzf Mappings
        nnoremap <C-p> :Files .<CR>
        nnoremap <C-m> :Buffers<CR>
        nnoremap <C-n> :<C-U>call CurrentBufferFiles()<CR>

        "" Custom fzf find files in directory of active buffer
        function! CurrentBufferFiles()
          execute 'FZF' expand('%:p:h')
        endfunction

        " Coc LSP
        let s:LSP_CONFIG = {
        \  "haskell": {
        \    "command": "haskell-language-server-wrapper",
        \    "args": ["--lsp"],
        \    "rootPatterns": ["*.cabal", ".stack.yaml", "cabal.project"," package.yaml"],
        \    "filetypes": ["hs", "lhs", "haskell"],
        \    "initializationOptions": {
        \      "haskell": {
        \      }
        \    }
        \  },
        \  "elm": {
        \    "command": "elm-language-server",
        \    "filetypes": ["elm"],
        \    "rootPatterns": ["elm.json"],
        \    "initializationOptions": {
        \      "elmAnalyseTrigger": "change",
        \      "elmFormatPath": "elm-format",
        \      "elmTestPath": "elm-test"
        \    }
        \  }
        \}

        let s:languageservers = {}
        for [lsp, config] in items(s:LSP_CONFIG)
          let s:not_empty_cmd = !empty(get(config, 'command'))
          if s:not_empty_cmd | let s:languageservers[lsp] = config | endif
        endfor

        if !empty(s:languageservers)
          call coc#config('languageserver', s:languageservers)
          endif
      '';
    };
  };

  home.stateVersion = "20.03";
}
