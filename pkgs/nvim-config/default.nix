{ pkgs }:

let customPlugins = import ./plugins.nix { inherit (pkgs) vimUtils fetchFromGitHub; };
in
{
  customRC = ''
    set history=700
    filetype plugin on
    filetype indent on
    set autoread
    let mapleader = "\<Space>"
    let g:mapleader = "\<Space>"
    nmap <leader>w :w!<cr>

    set so=7
    set wildmode=list:longest
    set wildignore=*.o,*~,*.pyc
    set wildignore+=*vim/backups*
    set wildignore+=*sass-cache*
    set wildignore+=*DS_Store*
    set wildignore+=vendor/rails/**
    set wildignore+=vendor/cache/**
    set wildignore+=*.gem
    set wildignore+=log/**
    set wildignore+=tmp/**
    set wildignore+=*.png,*.jpg,*.gif
    set cmdheight=2
    set hid
    set backspace=eol,start,indent
    set whichwrap+=<,>,h,l
    set ignorecase
    set smartcase
    set hlsearch
    set incsearch
    set inccommand=nosplit
    set lazyredraw
    set magic
    set showmatch
    set mat=2
    set noerrorbells
    set novisualbell
    set tm=500
    set scrolloff=8
    set sidescrolloff=15
    set sidescroll=1
    set number
    set showcmd

    set termguicolors
    if filereadable("/home/alistair/.config/colourscheme") && readfile("/home/alistair/.config/colourscheme") == ['dark']
        set background=dark
    elseif filereadable("/home/alistair/.config/colourscheme") && readfile("/home/alistair/.config/colourscheme") == ['light']
        set background=light
    endif

    if has("gui_running")
        set guioptions-=T
        set guioptions+=e
        set guitablabel=%M\ %t
    endif

    set encoding=utf8
    set ffs=unix,dos,mac

    set nobackup
    set nowb
    set noswapfile

    if has('persistent_undo') && !isdirectory(expand('~').'/.config/nvim/backups')
      silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
      set undodir=~/.config/nvim/backups
      set undofile
    endif

    set expandtab
    set smarttab
    set shiftwidth=4
    set tabstop=4
    set lbr
    set tw=500
    set ai
    set si
    set wrap
    set list listchars=tab:\ \ ,trail:·

    vnoremap <silent> * :call VisualSelection('f')<CR>
    vnoremap <silent> # :call VisualSelection('b')<CR>

    map j gj
    map k gk
    map <silent> <leader><cr> :noh<cr>
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l
    map <leader>bd :Bclose<cr>
    map <M-1> :b1<cr>
    map <M-2> :b2<cr>
    map <M-3> :b3<cr>
    map <M-4> :b4<cr>
    map <M-5> :b5<cr>
    map <M-6> :b6<cr>
    map <M-7> :b7<cr>
    map <M-8> :b8<cr>
    map <M-9> :b9<cr>
    map <M-0> :b10<cr>
    map <leader>ba :1,$bd!<cr>
    map <leader>bd :Bclose<cr>
    map <leader>tn :tabnew<cr>
    map <leader>to :tabonly<cr>
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove
    map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
    map <leader>cd :cd %:p:h<cr>:pwd<cr>
    try
      set switchbuf=useopen,usetab,newtab
      set stal=2
    catch
    endtry
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
    set viminfo^=%

    map 0 ^
    nmap <M-j> mz:m+<cr>`z
    nmap <M-k> mz:m-2<cr>`z
    vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
    vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
    if has("mac") || has("macunix")
      nmap <D-j> <M-j>
      nmap <D-k> <M-k>
      vmap <D-j> <M-j>
      vmap <D-k> <M-k>
    endif
    nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

    vnoremap <silent> gv :call VisualSelection('gv')<CR>
    map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
    map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>
    vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
    map <leader>cc :botright cope<cr>
    map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
    map <leader>n :cn<cr>
    map <leader>p :cp<cr>

    noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

    map <leader>q :e ~/buffer<cr>

    map <leader>pp :setlocal paste!<cr>

    nnoremap p p=`]<C-o>
    nnoremap P P=`]<C-o>

    command! Bclose call <SID>BufcloseCloseIt()
    function! <SID>BufcloseCloseIt()
       let l:currentBufNum = bufnr("%")
       let l:alternateBufNum = bufnr("#")

       if buflisted(l:alternateBufNum)
         buffer #
       else
         bnext
       endif

       if bufnr("%") == l:currentBufNum
         new
       endif

       if buflisted(l:currentBufNum)
         execute("bdelete! ".l:currentBufNum)
       endif
    endfunction


    set noshowmode
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme='pencil'
    let g:deoplete#enable_at_startup = 1
    autocmd CompleteDone * pclose
    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
    colorscheme pencil
    syntax enable
  '';

  vam.knownPlugins = pkgs.vimPlugins // customPlugins;

  vam.pluginDictionaries = [
    {
      names = [
        "ale"
        "deoplete-nvim"
        "denite-nvim"
        "vim-airline"
        "vim-nix"
        "vim-colors-pencil"
        "The_NERD_tree"
      ];
    }
  ];
}
