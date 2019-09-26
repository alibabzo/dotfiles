" init.vim
scriptencoding utf-8

" Indenting {{{
set smarttab
set shiftround              " round indent to multiple of shiftwidth
set autoindent
" }}}

" UI config {{{
set number                  " show line numbers
set showcmd                 " show command in bottom bar
set cmdheight=2             " make command line larger
set cursorline              " highlight current line
filetype on
filetype plugin on
filetype indent on          " load filetype-specific indent files
set wildmenu                " visual autocomplete for command menu
set lazyredraw              " redraw only when necessary (not sure about this)
set showmatch               " highlight matching parentheses
set termguicolors           " full colour mode
set noerrorbells            " no beeps
set novisualbell            " no flashes
set hidden                  " no nagging about unwritten changes
set noswapfile              " disable annoying messages
set scrolloff=8             " keep 8 screen lines above/below cursor if possible
set wrap linebreak          " wrap long line, don't break words
set undofile                " store undo history

" synchronise system clipboard with unnamed register
set clipboard^=unnamed,unnamedplus

" show trailing spaces
set list listchars=tab:\ \ ,trail:·
" }}}

" Search and replace {{{
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set inccommand=nosplit      " replace as characters are entered
set ignorecase              " ignore case when searching
set smartcase               " unless search pattern contains uppercase
set magic                   " use extended regexps
" }}}

" Folding {{{
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldnestmax=10          " 10 nested fold max
set foldmethod=indent       " fold based on indent level
" }}}

" Keymaps {{{
let g:mapleader="\<Space>"  " set leader key

" make movements work properly on wrapped lines
nnoremap Y y$
nnoremap j gj
nnoremap k gk
nnoremap & g&
nnoremap $ g$
nnoremap 0 g0

nmap <M-j> mz:m+<cr>`z      " alt-[j,k] swaps lines
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

nmap <leader>w :w!<cr>
map <leader>ba :1,$bd!<cr>
map <leader>bd :Bclose<cr>

inoremap <C-V> <C-R>+
vnoremap <C-C> y
vnoremap <C-X> ygvd
cnoremap <C-V> <C-R>+
" }}}

" Auto commands {{{
augroup search
  autocmd InsertEnter * :setlocal nohlsearch
  autocmd InsertLeave * :setlocal hlsearch
augroup END

augroup buffer
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufReadPost * :DetectIndent
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" }}}

" Plugin manager (dein) {{{

"Add the dein installation directory into runtimepath
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')
  call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('autozimu/LanguageClient-neovim', {'build': 'bash install.sh', 'rev': 'next'})
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('ervandew/supertab')
  call dein#add('ciaranm/detectindent')
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif

set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='nord'

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let g:LanguageClient_serverCommands = {
      \ 'c': ['clangd'],
      \ 'cpp': ['clangd'],
      \ 'sh': ['bash-language-server', 'start'],
      \ 'haskell': ['hie-wrapper'],
      \ 'python': ['pyls'],
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \ 'yaml': ['yaml-language-server', '--stdio'],
      \ }

" let g:LanguageClient_hoverPreview = 'Always'

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" }}}

" Colours {{{
colorscheme nord            " set colourscheme
syntax enable               " enable syntax processing
" }}}
