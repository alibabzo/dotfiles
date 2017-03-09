{ pkgs }:

let customPlugins = import ./plugins.nix { inherit (pkgs) vimUtils fetchFromGitHub; };
in
{
  customRC = ''
    filetype plugin indent on

    " Full colour mode
    set termguicolors

    " No beeps/flashes
    set noerrorbells
    set novisualbell

    " Don't nag about unwritten changes
    set hidden

    " Disable annoying messages
    set noswapfile

    " Prevent lag
    set lazyredraw

    " Show relative line numbers
    set relativenumber number

    " Keep 8 screen lines above/below the cursor if possible
    set scrolloff=8

    " Show current command at the bottom line of screen
    set showcmd
    set cmdheight=2

    " Highlight matching bracket
    set showmatch

    " Always show tabline
    set showtabline=2

    " Wrap long line, don't break words
    set wrap linebreak

    " Ignore case when searching
    set ignorecase

    " ...unless search pattern contains upper-case characters
    set smartcase

    " Use magic patterns (extended regexps)
    set magic

    " Use incremental find/replace
    set incsearch
    set inccommand=nosplit

    " Show trailing spaces
    set list listchars=tab:\ \ ,trail:·

    """ Tabs are spaces
    set expandtab
    set smarttab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4

    "Round indent to multiple of 'shiftwidth' when indenting with > and <
    set shiftround

    " Do smart/autoindenting when starting a new line
    set smartindent
    set autoindent

    """ Keymaps
    " Like C and D, yank from cursor to end of line
    nnoremap Y y$
    " Move over wrapped lines the same as normal lines
    map j gj
    map k gk
    " Move to end/beginning of visual (wrapped or normal) line
    nnoremap & g&
    nnoremap $ g$
    nnoremap 0 g0
    " Copy/paste and move cursor to end of last operated text or end of putted text
    vnoremap <silent> y y`]
    vnoremap <silent> p p`]
    nnoremap <silent> p p`]
    " Auto center on search match
    noremap n nzz
    noremap N Nzz
    " Use alt-[j,k] to swap lines
    nmap <M-j> mz:m+<cr>`z
    nmap <M-k> mz:m-2<cr>`z
    vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
    vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
    " Move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    " super-overwrite
    " from https://wikileaks.org/ciav7p1/cms/page_4849889.html
    cmap w!! w !sudo tee % > /dev/null

    """ Leader keymaps
    let mapleader = "\<Space>"
    let g:mapleader = "\<Space>"
    nmap <leader>w :w!<cr>
    map <leader>ba :1,$bd!<cr>
    map <leader>bd :Bclose<cr>
    map <leader>tn :tabnew<cr>
    map <leader>to :tabonly<cr>
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove
    map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

    """ Auto commands
    " Toggle hl off when entering insert mode
    autocmd InsertEnter * :setlocal nohlsearch
    " Toggle back on when leaving
    autocmd InsertLeave * :setlocal hlsearch
    " Delete trailing whitespace
    autocmd BufWritePre * %s/\s\+$//e
    " Return to last edit position when opening files
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif

    """ Abbreviations
    " Common mistakes when typing commandss
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Wq wq
    cnoreabbrev WQ wq
    cnoreabbrev Tabe tabe

    """ Plugins
    " Airline
    set noshowmode
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme='nord'

    " Deoplete
    let g:deoplete#enable_at_startup = 1
    autocmd CompleteDone * pclose
    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

    " Colourscheme
    if filereadable(expand('~').'/.config/colourscheme')
      let scheme = readfile(expand('~').'/.config/colourscheme')
      if scheme == ['light']
        colorscheme one
        set background=light
      else
        colorscheme nord
      endif
    endif

    " Enable syntax highlighting
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
        "nord-vim"
        "vim-one"
        "The_NERD_tree"
      ];
    }
  ];
}
