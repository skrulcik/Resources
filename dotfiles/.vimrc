" Scott Krulcik vimrc
" Adapted from Jake Zimmerman's
" github.com/jez
set nocompatible

" Package Management --------------------------------------
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Appearance
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'

" File Management
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" Code Editing
Plugin 'scrooloose/syntastic'
Plugin 'plasticboy/vim-markdown'
Plugin 'szw/vim-tags'
Plugin 'majutsushi/tagbar'
Plugin 'ntpeters/vim-better-whitespace' " Highlight and strip trailing whitespace
Plugin 'godlygeek/tabular' " Align CSV files at commas, align Markdown tables, and more
Plugin 'HTML-AutoCloseTag' " Automaticall insert the closing HTML tag

" Mostly cuz Jake is proud of this
Plugin 'jez/vim-superman'

" Misc
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()

filetype plugin indent on

" General Settings ----------------------------------------
set backspace=indent,eol,start
set incsearch
set hlsearch

" Code - syntax colors, line numbers, cursor position
syntax on
set number
set ruler

" Whitespace 
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

" Plugin Settings -----------------------------------------
" Solarized colors:
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
" Airline
set laststatus=2
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
" Nerdtree
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=0
" Syntastic
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END
" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1
" tagbar
"Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
" autocmd BufEnter * nested :call tagbar#autoopen(0)
" git gutter
hi clear SignColumn
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1
" Tabularize
:abbrev Table Tabularize

" Command Summary
" \t = View File Tree
" \b = View Outline
" ctrl+p -> fuzzyfind -> ctrl+t = fuzzy find new tab
" :AV = Open Counterpart/Alternative
" :Tab /<exp> = align on <exp>
