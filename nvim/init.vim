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
Plug 'alx741/vim-hindent', {
  \ 'for': ['haskell']
\ }

" Linting & Analysis
Plug 'w0rp/ale'

" Completion
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
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh && yarn global add ocaml-language-server flow-language-server',
    \ }
Plug 'junegunn/fzf'

" Other plugins (not supported by polyglot)
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

" --- HELPER FUNCTIONS ---

function CheckIfFileExists(filename)
  if filereadable(a:filename)
    return 1
  endif

  return 0
endfunction


" --- GENERAL CONFIG ---

" Disable compatabliltiy with vi
set nocompatible

" Hide buffer (file) instead of abandoning when switching
set hidden

" set max line length
set colorcolumn=80

" show invisibles
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
autocmd FileType elm,haskell,java setlocal tabstop=4 shiftwidth=4

" Color/Theme
set background=dark

" Configure vim-colorschemes -- MUST COME BEFORE 'highlighting LineNr'
colorscheme blackboard

" Set view attributes
set number
set ruler
set cursorline
highlight LineNr ctermfg=grey

" Make <Shift><K> inverse of <Shift><J>
nnoremap K i<CR><Esc>

" Set Leader
let mapleader="\<SPACE>"

" --- PLUGIN CONFIG ---

" Open Ctrl-P
nnoremap <Leader>o :CtrlP<CR>
" Open Ctrl-P buffer{
nnoremap <Leader>b :CtrlPBuffer<CR>
" Ctrl-P ignores
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/deps/*,*/_build/*,*/dist/*,*/build/*,*/legacy/*

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

" Configure vim-haskell & vim-hindent options
let g:haskell_indent_disable = 1
let g:hindent_on_save = 1
let g:hindent_indent_size = 4
let g:hindent_line_length = 100 

" Configure NERD Commenter
let g:NERDSpaceDelims = 1

" Configure airline status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
set t_Co=256

" Configure reason-vim
" let g:vimreason_extra_args_expr_reason = '"--print-width 90"'
autocmd BufWritePre *.re,*.rei,*.ml,*.mli ReasonPrettyPrint

" Configure elm-vim
" let g:elm_format_autosave = 1
" let g:elm_setup_keybindings = 0

" Configure neosnippet (flow autocomplete)
let g:neosnippet#enable_completed_snippet = 1

" Enable completion where available.
let g:ale_completion_enabled = 1
" Force Ale gutter to be always open
let g:ale_sign_column_always = 1
" Show Ale errors in status line
let g:airline#extensions#ale#enabled = 1
" Disable GHC linter if in a Haskell Stack project
if (CheckIfFileExists("./stack.yaml") == 1)
  let g:ale_linters = {
  \   'haskell': ['stack-build', 'hlint'],
  \}
endif

" Configure indent lines
let g:indentLine_char = '|'

" Configure language client
" set hidden - set above

let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'javascript': ['flow-language-server', '--stdio'],
    \ 'javascript.jsx': ['flow-language-server', '--stdio'],
    \ 'haskell': ['hie', '--lsp'],
    \ }

" Adding js/ts language server does work with flow
" https://github.com/sourcegraph/javascript-typescript-langserver/issues/390
" \ 'javascript': ['javascript-typescript-stdio'],
" \ 'javascript.jsx': ['javascript-typescript-stdio'],

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Configure NCM
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>" : "\<CR>")
set shortmess+=c
