" init.vim

" Spaces and tabs {{{
set tabstop=4               " number of visual spaces per tab
set softtabstop=4           " number of spaces in tab when editing
set expandtab               " tabs are spaces
" }}}

" UI config {{{
set number                  " show line numbers
set showcmd                 " show command in bottom bar
set cursorline              " highlight current line
filetype plugin indent on   " load filetype-specific indent files
set wildmenu                " visual autocomplete for command menu
set lazyredraw              " redraw only when necessary (not sure about this)
set showmatch               " highlight matching parentheses
" }}}

" Search and replace {{{
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set inccommand=nosplit      " replace as characters are entered
" }}}

" Folding {{{
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldnestmax=10          " 10 nested fold max
set foldmethod=indent       " fold based on indent level
" }}}

" Leader shortcuts {{{
let mapleader=","
" }}}

" Plugin manager (dein) {{{
if &compatible
  set nocompatible
endif

set runtimepath+=/home/alistair/.local/share/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('/home/alistair/.local/share/dein')
  call dein#begin('/home/alistair/.local/share/dein')
  call dein#add('/home/alistair/.local/share/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('ervandew/supertab')
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif

let g:airline_theme='nord'

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
" }}}

" Colours {{{
colorscheme nord            " set colourscheme
syntax enable               " enable syntax processing
" }}}
