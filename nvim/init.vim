" Set shell
set shell=/run/current-system/sw/bin/fish

" Configure vim-polygot disables
let g:polyglot_disabled = ['reason', 'elm']

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

" Features
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

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
Plug 'ChrisWellsWood/roc.vim'

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
nnoremap <silent> <esc> :noh<cr><esc>
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
" nnoremap <C-J> <C-W>j
" nnoremap <C-K> <C-W>k
" nnoremap <C-L> <C-W>l
" nnoremap <C-H> <C-W>h
" set splitbelow
" set splitright

" ------ PLUGIN CONFIG ------
" Configure vim moothie
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
let g:neoformat_enabled_rust = ['rustfmt']
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
let g:coc_node_path = '/run/current-system/sw/bin/node'
let g:coc_global_extensions = [
  \ 'coc-syntax',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-reason',
  \ 'coc-rust-analyzer',
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

" Custom fzf find files in directory of active buffer
function! CurrentBufferFiles()
  execute 'FZF' expand('%:p:h')
endfunction

" Coc LSP, only for COC plugins that don't handle this automatically
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
