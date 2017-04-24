"------ Visual options ------"

set termguicolors                   " full colour mode
syntax enable                       " enable syntax highlighting
set relativenumber number           " enable relative line numbers
set wrap                            " enable word wrap
set linebreak                       " don't break words
set novisualbell                    " disable flashes
set noerrorbells                    " disable beeps
set showmatch                       " show matching bracket
set lazyredraw                      " Prevent lag
set showcmd                         " Show current command at the bottom line of screen
set cmdheight=2                     " Command line is 2 lines high
set scrolloff=8                     " Keep 8 screen lines above/below cursor
set showtabline=2                   " Always show tabline

"------ Behaviour ------"

set backspace=indent,eol,start      " normal backspace behaviour
set history=1000                    " 1000 item history
set undolevels=1000                 " 1000 item undo buffer
let g:mapleader = "\<Space>"        " set leader to spacebar
let g:maplocalleader="\<Space>"     " set leader harder
set title                           " update terminal title
set tabstop=4                       " tab = 4 spaces
set softtabstop=4
set shiftwidth=4                    " indent to 4 spaces
set expandtab                       " use spaces instead of tabs
set smarttab                        " indent with tab
set autoindent                      " auto indent
set smartindent                     " use vim smart indenting

set iskeyword+=_,$,@,%,#
set wildmode=longest,list:longest   " Shell style tab completion

filetype indent on
filetype plugin on

set encoding=utf-8
scriptencoding utf-8


set clipboard+=unnamedplus          " Share clipboard
set wildmenu                        " Better tab completion

"------ Searching ------"

set incsearch                       " Search while typing
set inccommand=nosplit              " Replace while typing
set ignorecase                      " Case insensitive searching
set smartcase                       " ...except when searches contain uppercase
set hlsearch                        " highlight all search results

"------ Buffers ------"

set hidden                          " Don't nag about unwritten changes

"------ Windows ------"

" Move easily between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Keybindings for splitting windows
noremap <Leader>v :split<CR>
noremap <Leader>V :vsplit<CR>

"------ Text width ------"

set textwidth=80
set shiftround                      " Round indent to a multiple of 'shiftwidth'

"------ Helpful keybindings ------"

" Common mistakes when typing commandss
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq

" Like C and D, yank from cursor to end of line
nnoremap Y y$

" Move over wrapped lines the same as normal lines
map j gj
map k gk

" Move to end/beginning of visual (wrapped or normal) line
nnoremap & g&
nnoremap $ g$
nnoremap 0 g0

" Use alt-[j,k] to swap lines
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" super-overwrite
" credit https://wikileaks.org/ciav7p1/cms/page_4849889.html
cmap w!! w !sudo tee % > /dev/null

" Helpful leader commands
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
map <leader>ba :1,$bd!<cr>
map <leader>bd :bdelete<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/


"------ Colourscheme ------"

if filereadable(expand('~').'/.config/colourscheme')
    let s:scheme = readfile(expand('~').'/.config/colourscheme')
    if s:scheme == ['light']
        colorscheme one
        set background=light
    else
        colorscheme nord
    endif
endif

"------ Whitespace ------"

" Show trailing spaces
set list listchars=tab:\ \ ,trail:·

"------ Auto commands ------"

augroup bufferActions
    autocmd!

    " Toggle hl off when entering insert mode,
    " turn back on when leaving
    autocmd InsertEnter * :setlocal nohlsearch
    autocmd InsertLeave * :setlocal hlsearch

    " Delete trailing whitespace
    autocmd BufWritePre * %s/\s\+$//e

    " Return to last edit position when opening files
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
augroup END



"------ Persistent undo ------"

set undodir=$HOME/.config/nvim/undo/
set undoreload=10000
set undofile
"-----------------------------"
"     Plugin configuration    "
"-----------------------------"

"------ Airline ------"

set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme='nord'

"------ Deoplete ------"

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 0

augroup deopleteActions
    autocmd!
    autocmd CompleteDone * pclose
augroup END

imap <expr><S-TAB> pumvisible() ? "\<C-n>" : "\<S-TAB>"
smap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

"------ NERDTree ------"

let g:NERDTreeIgnore=['\.git$']

"------ NeoSnippet ------"

imap <C-f>     <Plug>(neosnippet_expand_or_jump)
smap <C-f>     <Plug>(neosnippet_expand_or_jump)
xmap <C-f>     <Plug>(neosnippet_expand_target)

imap <expr><TAB>    neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"

smap <expr><TAB>    neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"------ NeoMake ------"

augroup neomakeActions
    autocmd!
    autocmd BufEnter * Neomake
    autocmd BufWritePost * Neomake
augroup END

map <leader>er :Neomake<cr>
map <leader>en :lnext<cr>
map <leader>ep :lprevious<cr>
