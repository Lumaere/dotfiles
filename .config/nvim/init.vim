
" Do plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'

" visual
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'

" file search
Plug 'ctrlpvim/ctrlp.vim' " Because command-t requires ruby and thats a hassle

" formatting
Plug 'godlygeek/tabular'

" autocomplete plugins
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neoinclude.vim'
Plug 'zchee/deoplete-clang'
call plug#end()

" set bash environment aliases
let $BASH_ENV = "~/.config/bash/aliases"
let mapleader = " "            " Remap leader key to something closer

" Set defaults
set number                      " hybrid numbering
set relativenumber              " relative numbering
set tabstop=4                   " tab is four spaces
set shiftwidth=4                " number of spaces for autoindent
set softtabstop=4
set expandtab
set incsearch                   " jumps to search
set ignorecase                  " ignore case in searches in general
set smartcase                   " do case-sensitive search if capital letter
set splitbelow                  " open new sp below
set splitright                  " open new vs to right
set showcmd                     " show (partial) command in msg window
set noea                        " don't resize splits on closing one
set fillchars+=vert:\           " Remove '|' in VS
set lazyredraw
set history=1000                " increase history buffer limit
set backspace=indent,eol,start  " backspace works like expected in ins
set pastetoggle=<F2>            " change for pasting in from outside
set completeopt=menu,menuone    " no preview window
set pumheight=10                " Limit popup menu height

" menu completion will show list of available options
set wildmenu
set wildmode=longest:list,full

" ignore various build/environment directories directories
set wildignore+=**/env/**
set wildignore+=**/node_modules/**
set wildignore+=**/CMakeFiles/**

" set vim meta files
set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/backup//
set viminfo+=n~/.config/nvim/viminfo

" set persistent undo
set undofile
set undodir=~/.config/nvim/undo " where to save undo histories
set undolevels=1000     " How many undos
set undoreload=10000    " number of lines to save for undo

" whitespace and display invisible
set showbreak=↪
set wrap
set cpo=n
set list
set listchars=tab:▸\ ,trail:·

" folding
set foldenable
set foldmethod=indent
set foldlevelstart=99

" syntax
syntax enable

" TODO and FIXME highlighting
syn match cNotification contained "\<\(TODO\|FIXME\|NOTE\):"

set background=dark " for whatever reason this makes some fonts bold
set t_md=           " so no bold fonts
colorscheme github
filetype plugin indent on

hi TabLineFill ctermbg=15 ctermfg=15
hi TabLine ctermbg=15
hi Title ctermfg=24

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/mappings.vim
source ~/.config/nvim/commands.vim
source ~/.config/nvim/autocmds.vim
source ~/.config/nvim/functions.vim

" ABCDEFGHIJKLM
" NOPQRSTUVWXYZ
" abcdefghijklm
" nopqrstuvwxyz
"  1234567890
" ~!@#$%^&*_+-
" {}[]()\/?<>.

