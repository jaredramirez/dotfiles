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

" Completion - This automatically integrates language client
Plug 'lifepillar/vim-mucomplete'

" LanguageClient
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

" Syntax highlighting / themes
Plug 'sheerun/vim-polyglot'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'haishanh/night-owl.vim'

" Other syntax highlighting - for the (few) languages not supported by polyglot
" or for polygot packages that I dislike
Plug 'reasonml-editor/vim-reason-plus'
Plug 'lambdatoast/elm.vim'
Plug 'milch/vim-fastlane'

" Status Bar
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

call plug#end()

" ------ GENERAL CONFIG ------

" Disable compatabliltiy with vi
set nocompatible

" Hide buffer instead of abandoning when switching
set hidden

" Set max line length for JS/TS
autocmd BufRead,BufNewFile *.js,*jsx,*.ts,*.tsx setlocal colorcolumn=80

" Set spelling
set spell spelllang=en_us

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

set background=dark
colorscheme night-owl
highlight PMenu guibg=#0B2942 ctermbg=16 gui=NONE cterm=NONE
highlight PMenuSel guibg=#54738C ctermbg=66 gui=NONE cterm=NONE
highlight Comment gui=italic cterm=italic
highlight CursorLine guifg=NONE ctermfg=NONE guibg=#01121F ctermbg=16
highlight CursorLineNR guifg=#C5E4FD ctermfg=179
highlight Visual guifg=NONE ctermfg=NONE guibg=#0B2942 ctermbg=16 gui=NONE cterm=NONE
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

" ------ PLUGIN CONFIG ------

" Configure Ctrl-P

" Open Ctrl-P
nnoremap <Leader>o :CtrlP<CR>
" Open Ctrl-P buffer
nnoremap <Leader>b :CtrlPBuffer<CR>
" Ctrl-P ignores
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/deps/*,*/_build/*,*/dist/*,*/build/*,*/legacy/*,*/elm-stuff/*

" Configure syntax both vim-polygot & others
let g:polyglot_disabled = ['reason', 'elm']
let g:javascript_plugin_flow = 1

" Configure rainbow parentheses
let g:rainbow_active = 1
let g:rainbow_conf = {
  \ 'guifgs': ['#5FD7FF', '#FFFFAF', '#AFFFFF', '#FFD7FF'],
  \ 'ctermfgs': ['51', '229', '159', '225'],
  \ 'parentheses': [
    \ 'start=/(/ end=/)/ fold',
    \ 'start=/\[/ end=/\]/ fold',
    \ 'start=/{\(-|\)\@!/ end=/\(-\)\@<!}/ fold'
  \],
\}

" Configure vim-prettier

" Make Prettier async
let g:prettier#exec_cmd_async = 1
" Disable quickfix
let g:prettier#quickfix_enabled = 0
" Make Prettier run on filesave
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" Set prettier back to defaults (vim-prettier has different defaults)
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'

" Configure NERD Commenter
let g:NERDSpaceDelims = 1

" Vim status line
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? '  '.l:branchname.' ' : ' '
endfunction

set laststatus=2
set statusline=
set statusline+=\%{StatuslineGit()}
set statusline+=\››
set statusline+=\ %t
set statusline+=%=
set statusline+=\ ‹‹
set statusline+=\ %y
set statusline+=\ /|
set statusline+=\ %l:%c
set statusline+=\ ››

highlight StatusLine guifg=#0B2942 guibg=#D2DEE7
highlight StatusLineTermNC guifg=#010E1A guibg=#5F7E97

" Configure buftabline
let g:buftabline_indicators = 1
highlight BufTabLineFill guifg=#5F7E9 guibg=#010E1A
highlight BufTabLineCurrent guifg=#D2DEE7 guibg=#0B2942
highlight BufTabLineHidden guifg=#5F7E97 guibg=#010E1A

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
" Language servers provide a much better experience, and while Ale + LS can be
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
let g:indentLine_char = '▏'

" Configure MUComplete
set completeopt=noinsert,menuone,noselect
let g:mucomplete#enable_auto_at_startup = 1

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
let g:LanguageClient_serverCommands = {
    \ 'elm': ['elm-language-server-exe'],
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'haskell': ['hie-wrapper'],
    \ 'rust': ['rls'],
    \ 'ocaml': ['reason-language-server.exe'],
    \ }
let g:LanguageClient_rootMarkers = {
    \ 'elm': ['elm.json'],
    \ 'javascript': ['package.json'],
    \ 'reason': ['bs.config'],
    \ 'haskell': ['stack.yaml', '*.cabal'],
    \ 'rust': ['Cargo.toml'],
    \ }

" Mappings for interacting with langauge server
map <silent> <Leader>ls :call LanguageClient_contextMenu()<CR>

" Configure Dash
nmap <silent> <leader>s <Plug>DashSearch

" Configure Git Gutter
highlight GitGutterAdd ctermfg=149 ctermbg=NONE guifg=#addb67 guibg=NONE
highlight GitGutterChange ctermfg=116 ctermbg=NONE guifg=#011627 guibg=NONE
highlight GitGutterDelete ctermfg=204 ctermbg=NONE guifg=#ff5874 guibg=NONE
