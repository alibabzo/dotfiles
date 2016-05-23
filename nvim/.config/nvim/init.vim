" ==================== General configuration ====================

set number			" line numbers on
set backspace=indent,eol,start	" Allow backspace in insert mode
set history=1000		" Lots of :cmdline history
set showcmd			" Show incomplete commands
set noshowmode			" Don't show current mode (got airline for that)
set visualbell			" No sounds
set autoread			" Reload files changed outside nvim

" turn on syntax highlighting
syntax on 
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call deoplete#enable()

" =================== vim-plug configuration ====================
" Loads plugins 

call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'mhartington/oceanic-next'
Plug 'othree/yajs.vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
call plug#end()

" ===================== Turn off swap files =====================

set noswapfile
set nobackup 
set nowb

" ====================== Persistent undo ========================
" Keep undo history across sessions by storing in file.

if has('persistent_undo') && !isdirectory(expand('~').'/.config/nvim/backups')
  silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
  set undodir=~/.config/nvim/backups
  set undofile
endif

" ======================== Indentation ==========================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto-indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" =========================== Folds =============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ========================= Completion ==========================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ========================== Scrolling ==========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ============================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ========================== NERDTree ===========================
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" =========================== Theme =============================

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme OceanicNext
let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts = 1
set background=dark
