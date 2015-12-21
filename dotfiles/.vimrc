" Scott Krulcik vimrc

" Pathogen package manager
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" vim-airline
runtime ~/.vim/bundle/vim-airline/autoload/airline.vim
let g:airline_powerline_fonts = 1
set laststatus=2
set ttimeoutlen=50
let g:airline#extensions#tabline#enabled = 1

" Configure to edit code: syntax colors, line numbers, cursor position
syntax on
set number
set ruler

" Ensure that we are in modern vim mode, not backwards-compatible vi mode
" From .vimrc_gpi from CMU GPI class
set nocompatible
set backspace=indent,eol,start

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" Change indent to 4 spaces and tab to 4 spaces
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Show multicharacter commands as they are being typed
set showcmd

" Enable mouse for supported terminals
if has('mouse')
    set mouse=a
endif

