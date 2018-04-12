" --- PLUGINS ---

call plug#begin('~/.config/nvim/bundle')

" Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sjbach/lusty'
Plug 'christoomey/vim-tmux-navigator'

" Code formatting
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue']
\ }

" Linting AND code formatting
" For Reason formatting -> https://github.com/reasonml/reason-cli
" For Elm formatting -> https://github.com/avh4/elm-format
" For Rust formatting -> https://github.com/rust-lang-nursery/rustfmt
" For Haskell formatting -> https://www.google.com/search?q=hfmt&ie=utf-8&oe=utf-8&client=firefox-b-1-ab
Plug 'w0rp/ale'

" Completion - Not used a ton, I mostly rely on language severs + ncm for completion
Plug 'roxma/nvim-completion-manager'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'roxma/ncm-elm-oracle'
Plug 'roxma/ncm-flow'
Plug 'Shougo/neco-syntax'
Plug 'calebeby/ncm-css'
Plug 'eagletmt/neco-ghc'
Plug 'roxma/nvim-cm-tern', {'do': 'npm install'}

" Language Client (Ties into NCM)
" For Haskell langauge server -> https://github.com/haskell/haskell-ide-engine
" For Rust langauge server -> https://github.com/rust-lang-nursery/rls
" For Ocamel/Reason language server -> https://github.com/freebroccolo/ocaml-language-server<Paste>
" For Flow(JS) language server -> https://github.com/flowtype/flow-language-server
" For Typescript language server -> https://github.com/sourcegraph/javascript-typescript-langserver
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf'

" Other syntax files - for the (few) languages not supported by polyglot
Plug 'reasonml-editor/vim-reason-plus', {
  \ 'for': ['reason']
\ }

" Misc
Plug 'tpope/vim-sensible'
Plug 'wakatime/vim-wakatime'
Plug 'mileszs/ack.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'

call plug#end()

" --- GENERAL CONFIG ---

" Disable compatabliltiy with vi
set nocompatible

" Hide buffer (file) instead of abandoning when switching
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
set ts=2 sw=2 et
autocmd FileType elm,java setlocal tabstop=4 shiftwidth=4

" Color/Theme
set background=dark

" Configure vim-colorschemes -- MUST COME BEFORE 'highlighting LineNr'
colorscheme blackboard
" Make line numbers readable with this theme
highlight LineNr ctermfg=grey 

" Set view attributes
set number
set ruler
set cursorline

" Make <Shift><K> inverse of <Shift><J>
nnoremap K i<CR><Esc>

" Set Leader
let mapleader="\<SPACE>"

" --- PLUGIN CONFIG ---

" Configure Ctrl-P

" Open Ctrl-P
nnoremap <Leader>o :CtrlP<CR>
" Open Ctrl-P buffer
nnoremap <Leader>b :CtrlPBuffer<CR>
" Ctrl-P ignores
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/deps/*,*/_build/*,*/dist/*,*/build/*,*/legacy/*

" Configure Prettier

" Make Prettier async
let g:prettier#exec_cmd_async = 1
" Disable opening quickfix
let g:prettier#quickfix_enabled = 0
" Disable prettier on files with "@format" tag
let g:prettier#autoformat = 0
" Make Prettier run on filesave, textchange & leave insert
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" Prettier options
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'false'
let g:prettier#config#trailing_comma = 'all'


" Configure NERD Commenter
let g:NERDSpaceDelims = 1

" Configure airline status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
set t_Co=256

" Configure Ale
let g:ale_fix_on_save = 1

" Configure auto-formatters
" Must install formatters separately
let g:ale_fixers = {
\   'reason': ['refmt'],
\   'elm': ['elm-format'],
\   'rust': ['rustfmt'],
\   'haskell': ['hfmt']
\}
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1

" Disable Ale linters for language that there is a language server for
" Langauge servers provide a much better experience, and while Ale + LS can be
" used together, I prefer to disable Ale
let g:ale_linters = {
\   'reason': [],
\   'ocaml': [],
\   'haskell': [],
\   'rust': [],
\   'typescript': [],
\   'javascript': [],
\}

" Configure indent lines
let g:indentLine_char = '|'

" Configure language client

" This is required for langauge client, but is already set above
" set hidden

" Configure each filetype & language server to go with it
let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'javascript': ['flow-language-server', '--stdio'],
    \ 'javascript.jsx': ['flow-language-server', '--stdio'],
    \ 'haskell': ['hie', '--lsp'],
    \ 'rust': ['rls'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescript.jsx': ['javascript-typescript-stdio'],
    \ }

" javascript-typescript-stdio language server does work with flow
" https://github.com/sourcegraph/javascript-typescript-langserver/issues/390

" Mappings for interacting with langauge server
nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> gr :call LanguageClient_textDocument_rename()<CR>

" Configure NCM
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>" : "\<CR>")
set shortmess+=c
