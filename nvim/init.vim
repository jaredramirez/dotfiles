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
" For Prettier -> https://github.com/prettier/prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue']
\ }
" For ReasonML formatting -> https://github.com/reasonml/reason-cli
" For Elm formatting -> https://github.com/avh4/elm-format
" For Rust formatting -> https://github.com/rust-lang-nursery/rustfmt
" For Haskell formatting -> http://hackage.haskell.org/package/hfmt
Plug 'w0rp/ale'

" Completion - I mostly rely on language severs + ncm2 for completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'

Plug 'ncm2/ncm2-syntax'
Plug 'Shougo/neco-syntax'

Plug 'ncm2/ncm2-vim'
Plug 'Shougo/neco-vim'

" LanguageClient (Ties into ncm2)
" For Haskell langauge server -> https://github.com/haskell/haskell-ide-engine
" For Rust langauge server -> https://github.com/rust-lang-nursery/rls
" For Ocaml/Reason language server -> https://github.com/freebroccolo/ocaml-language-server
" For Flow(JS) language server -> https://github.com/flowtype/flow-language-server
" For Typescript language server -> https://github.com/sourcegraph/javascript-typescript-langserver
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Fuzzy finder - also used in the language server complemention menu
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Git
Plug 'airblade/vim-gitgutter'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'luochen1990/rainbow'
Plug 'haishanh/night-owl.vim'
Plug 'lambdatoast/elm.vim'

" Other syntax highlighting - for the (few) languages not supported by polyglot
Plug 'reasonml-editor/vim-reason-plus', {
  \ 'for': ['reason']
\ }
Plug 'milch/vim-fastlane'

" Status Bar
Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-buftabline'

" For Dash -> https://kapeli.com/dash
Plug 'rizzatti/dash.vim'
" For Wakatime -> https://kapeli.com/dash
Plug 'wakatime/vim-wakatime'
" For Ack -> https://beyondgrep.com/
Plug 'mileszs/ack.vim'

" Code Commenter
Plug 'scrooloose/nerdcommenter'

" Defaults
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'

if exists('$TMUX')
  Plug 'christoomey/vim-tmux-navigator' " See README for tmux setup
  Plug 'edkolev/tmuxline.vim'
  Plug 'ncm2/ncm2-tmux'
endif

call plug#end()

" ------ GENERAL CONFIG ------

" Disable compatabliltiy with vi
set nocompatible

" Hide buffer instead of abandoning when switching
set hidden

" Set max line length for JS/TS
autocmd BufRead,BufNewFile *.js,*jsx,*.ts,*.tsx setlocal colorcolumn=80

" Turn off spellcheck
set nospell

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

" Set tabs
set tabstop=2
set shiftwidth=2
set expandtab
autocmd FileType elm,java setlocal tabstop=4 shiftwidth=4

" Color/Theme
if (has("termguicolors"))
 set termguicolors
endif

set background=dark
colorscheme night-owl
highlight PMenuSel guibg=#54738C ctermbg=66 gui=NONE cterm=NONE
highlight Comment cterm=italic
highlight CursorLine guifg=NONE ctermfg=NONE guibg=#01121F ctermbg=16
highlight CursorLineNR guifg=#C5E4FD ctermfg=179
highlight clear Error

" Set view attributes
set number
set ruler
set cursorline

" Make <Shift><K> inverse of <Shift><J>
nnoremap K i<CR><Esc>

" Set Leader
let mapleader="\<SPACE>"

" Disabled Ctrl-C
inoremap <C-c> <Nop>

" Keep cursor in the center of the screen
set scrolloff=999


" ------ PLUGIN CONFIG ------

" Configure Ctrl-P

" Open Ctrl-P
nnoremap <Leader>o :CtrlP<CR>
" Open Ctrl-P buffer
nnoremap <Leader>b :CtrlPBuffer<CR>
" Ctrl-P ignores
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/deps/*,*/_build/*,*/dist/*,*/build/*,*/legacy/*,*/elm-stuff/*

" Configure vim-polygot
let g:polyglot_disabled = ['reason', 'elm']

" Configure rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
  \ 'guifgs': ['#5FD7FF', '#FFFFAF', '#AFFFFF', '#FFD7FF'],
  \ 'ctermfgs': ['51', '229', '159', '225'],
\}

" Configure vim-prettier

" Make Prettier async
let g:prettier#exec_cmd_async = 1
" Disable quickfix
let g:prettier#quickfix_enabled = 0
" Make Prettier run on filesave
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" Set prettier back to defaults (vim-prettier has differnt defaults)
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'

" Configure NERD Commenter
let g:NERDSpaceDelims = 1

" Configure lightline
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' },
  \ }

" Configure buftabline
let g:buftabline_indicators = 1
highlight BufTabLineFill guifg=#30302C ctermfg=58 guibg=#30302C ctermbg=58
highlight BufTabLineHidden guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE
highlight BufTabLineCurrent guibg=#4E4E43 ctermbg=59
highlight BufTabLineHidden guibg=#30302C ctermbg=58

" Configure tmuxline
if exists('$TMUX')
  autocmd VimEnter * Tmuxline
  let g:tmuxline_preset = 'powerline'
  let g:tmuxline_theme = 'lightline'
endif

" Configure Ale
let g:ale_fix_on_save = 1

" Error Display
highlight ALEError guifg=#ff5874 ctermfg=204 guibg=NONE ctermbg=NONE
highlight ALEErrorSign guifg=#ff5874 ctermfg=204 guibg=NONE ctermbg=NONE
highlight ALEWarning guifg=ffd17c ctermfg=222 guibg=NONE ctermbg=NONE
highlight ALEWarningSign guifg=#ffd17c ctermfg=222 guibg=NONE ctermbg=NONE
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1

" Configure auto-formatters
" \   'haskell': ['hfmt']
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'reason': ['refmt'],
\   'elm': ['elm-format'],
\   'rust': ['rustfmt'],
\}


" Disable Ale linters for language that there is a language server for
" Langauge servers provide a much better experience, and while Ale + LS can be
" used together, I prefer to disable Ale
let g:ale_linters = {
\   'reason': [],
\   'ocaml': [],
\   'haskell': [],
\   'rust': [],
\   'javascript': [],
\   'typescript': [],
\   'elm': []
\}

" Configure indentLine
let g:indentLine_char = '|'

" Configure ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Configure LanguageClient

" This is required for LanguageClient, but is already set above
" set hidden

" Always show sign column
set signcolumn=yes

" Configure each filetype & language server to go with it
" For Haskell langauge server -> https://github.com/haskell/haskell-ide-engine
" For Rust langauge server -> https://github.com/rust-lang-nursery/rls
" For Ocamel/Reason language server -> https://github.com/freebroccolo/ocaml-language-server<Paste>
" For Flow(JS) language server -> https://github.com/flowtype/flow-language-server
" For Typescript language server -> https://github.com/sourcegraph/javascript-typescript-langserver
" \ 'elm': ['elm-language-server-exe'],
let g:LanguageClient_serverCommands = {
    \ 'elm': ['elm-language-server-exe'],
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'javascript': ['flow-language-server', '--stdio'],
    \ 'javascript.jsx': ['flow-language-server', '--stdio'],
    \ 'haskell': ['hie-wrapper'],
    \ 'rust': ['rls'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescript.jsx': ['javascript-typescript-stdio'],
    \ }
let g:LanguageClient_rootMarkers = {
    \ 'elm': ['elm.json'],
    \ 'javascript': ['package.json'],
    \ 'reason': ['bs.config'],
    \ 'ocaml': ['*.opam'],
    \ 'haskell': ['stack.yaml'],
    \ 'rust': ['Cargo.toml'],
    \ }

let g:LanguageClient_loggingFile = './lc.log'
let g:LanguageClient_loggingLevel = 'DEBUG'

" javascript-typescript-stdio language server does work with flow
" https://github.com/sourcegraph/javascript-typescript-langserver/issues/390

" Mappings for interacting with langauge server
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>llh :call LanguageClient#textDocument_hover()<CR>
map <Leader>llg :call LanguageClient#textDocument_definition()<CR>
map <Leader>llr :call LanguageClient#textDocument_rename()<CR>
map <Leader>llf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>llb :call LanguageClient#textDocument_references()<CR>
map <Leader>lla :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>lls :call LanguageClient#textDocument_documentSymbol()<CR>

" Configure vim-poloygot
let g:javascript_plugin_flow = 1

" Configure Dash
nmap <silent> <leader>s <Plug>DashSearch
