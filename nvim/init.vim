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
" Ale can be used for more that just formatting, but because I
" use language servers, I use it pretty much exclusively for automatically
" formatting
Plug 'w0rp/ale'


" Coc (Full LSP support)
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}

" Snipits
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

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

" For Wakatime -> https://kapeli.com/dash
Plug 'wakatime/vim-wakatime'
" For Ack -> https://beyondgrep.com/
Plug 'mileszs/ack.vim'

" Code Commenter
Plug 'scrooloose/nerdcommenter'

" Defaults
Plug 'tpope/vim-sensible'
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
highlight Todo ctermfg=222 guifg=#ecc48d guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight Error guifg=#ff5874 ctermfg=204 guibg=NONE ctermbg=NONE


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
set statusline+=%#PMenuSel#
set statusline+=\%{StatuslineGit()}
set statusline+=%#StatusLine#
set statusline+=\
set statusline+=%#PMenu#
set statusline+=\ %t
set statusline+=%=
set statusline+=\%{coc#status()}
set statusline+=%#StatusLine#
set statusline+=\ 
set statusline+=%#PMenuSel#
set statusline+=\ %y
set statusline+=\ /|
set statusline+=\ %l:%c

highlight StatusLine guifg=#54738C guibg=#0B2942 gui=NONE cterm=NONE

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

" Configure buftabline
let g:buftabline_indicators = 1
highlight BufTabLineFill guifg=#5F7E9 guibg=#010E1A
highlight BufTabLineCurrent guifg=#D2DEE7 guibg=#0B2942
highlight BufTabLineHidden guifg=#5F7E97 guibg=#010E1A

" Configure Ale
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1

" Configure auto-formatters
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'reason': ['refmt'],
\   'elm': ['elm-format'],
\   'javascript': ['prettier'],
\   'javascript.jsx': ['prettier'],
\   'css': ['prettier'],
\   'sass': ['prettier']
\}

" Error Display
highlight ALEError guifg=#ff5874 ctermfg=204 guibg=NONE ctermbg=NONE
highlight ALEErrorSign guifg=#ff5874 ctermfg=204 guibg=NONE ctermbg=NONE
highlight ALEWarning guifg=ffd17c ctermfg=222 guibg=NONE ctermbg=NONE
highlight ALEWarningSign guifg=#ffd17c ctermfg=222 guibg=NONE ctermbg=NONE
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
let g:ale_sign_column_always = 1

" Configure indentLine
let g:indentLine_char = '▏'

" Configure Coc

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

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Highlights in general
highlight CocErrorFloat guifg=#ff5874 ctermfg=204 guibg=NONE ctermbg=NONE
highlight CocUnderline guifg=#ff5874 ctermfg=204 guibg=NONE ctermbg=NONE
highlight CocErrorSign guifg=#ff5874 ctermfg=204 guibg=NONE ctermbg=NONE
highlight CocHighlightText guifg=NONE ctermfg=NONE guibg=#3a4168 ctermbg=NONE

" Mapings
nnoremap <Leader><Leader>h :call <SID>show_documentation()<CR>
nnoremap <Leader><Leader>r <Plug>(coc-rename)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Configure Utilsnips
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Configure Git Gutter
highlight GitGutterAdd ctermfg=149 ctermbg=NONE guifg=#addb67 guibg=NONE
highlight GitGutterChange ctermfg=116 ctermbg=NONE guifg=#011627 guibg=NONE
highlight GitGutterDelete ctermfg=204 ctermbg=NONE guifg=#ff5874 guibg=NONE
