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

" Coc (Full LSP support)
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
Plug 'sheerun/vim-polyglot'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/landscape.vim'

" Other syntax highlighting - for the (few) languages not supported by polyglot
" or for polygot packages that I dislike
Plug 'reasonml-editor/vim-reason-plus'
Plug 'andys8/vim-elm-syntax'
Plug 'milch/vim-fastlane'
Plug 'jparise/vim-graphql'
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

" Clear searches
nnoremap <Leader><space> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

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
colorscheme landscape
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

" Configure light line

function! FilenameAndParentDir()
  return expand('%:p:h:t') . '/' . expand('%:t')
endfunction

let g:lightline = {
  \ 'colorscheme': 'landscape',
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

" Configure NERD Commenter
let g:NERDSpaceDelims = 1

" Configure Neoformat
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
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

inoremap <silent><expr> <cr>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
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
