" Scott Krulcik vimrc

" Acks:
" Originally inspired by Jake Zimmerman's vimrc  Jake: github.com/jez
" Also drew from jfrazelle, bezi

set nocompatible

" === Package Management ===
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Appearance
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
Plugin 'valloric/youcompleteme' " Autocomplete
Plugin 'ntpeters/vim-better-whitespace' " Strip trailing whitespace
Plugin 'godlygeek/tabular' " Align CSV files and Markdown tables
Plugin 'HTML-AutoCloseTag' " Automaticall insert the closing HTML tag
Plugin 'tmux-plugins/vim-tmux' " Syntax highlighting for tmux config

" Mostly cuz Jake is proud of this
Plugin 'jez/vim-superman'

" Misc
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()

" === General ===
set encoding=utf-8  " Encode files in UTF-8
set backspace=indent,eol,start
set incsearch       " Incremental search
set hlsearch        " Highlight all search terms
set ignorecase      " Allows case-insensitive file completion
set infercase       " Allows case-insensitive file completion
set smartcase       " Disallow case-insensitive if capitals are typed
set scrolloff=3     " Keeps a few lines between cursor and edge
set sidescrolloff=5 " Keeps a few columnns between cursor and edge
set showcmd         " Show multicharacter commands as they are being typed
set splitright      " vsplit to the right
set noswapfile      " Fewer annoying files
set nobackup        " Fewer annoying files
set wildmenu        " Show potential matches above completion,
set wildmode=full   "   completing the first immediately
" Force write readonly files using sudo
command! WS w !sudo tee %
" Replace escape to exit insert mode with jj, props to Bezi
inoremap jj <ESC>
if has('mouse')
    set mouse=a     " Allow mouse interaction
endif

" === Appearance ===
syntax on           " Syntax highlighting
set number          " Line numbers
set ruler           " Cursor position in file

" === Whitespace ===
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" === Keybindings ===
" Make navigating long, wrapped lines behave like normal lines
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$
noremap <silent> ^ g^
noremap <silent> _ g_

" Enable mouse for supported terminals

" Plugin Settings -----------------------------------------
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




" === Optional ===
" Those things that are nice, just not all the time
" set background=dark " Always keep a dark background
" set cursorline      " Highlights/underlines current editor line
" set cursorcolumn    " Highlights/underlines current editor column
" set cc=81           " Puts barrier line at 80 columns
set ttyfast         " idk but bezi claims smoother performance
" Long line handling, maybe do it per filetype
set wrap
set textwidth=79
set formatoptions=qrn1


" === File Types ===
filetype plugin indent on " Enable file type detection

augroup myFiletypes
  au!

  " Markdown files
  au BufRead,BufNewFile *.md setlocal filetype=markdown
  " Treat all .tex files as latex
  au BufRead,BufNewFile *.tex setlocal filetype=tex
  " LaTeX class files
  au BufRead,BufNewFile *.cls setlocal filetype=tex
  " Gradle files
  au BufRead,BufNewFile *.gradle setlocal filetype=groovy
  " gitconfig files
  au BufRead,BufNewFile gitconfig setlocal filetype=gitconfig

  " Turn on spell checking and 80-char lines by default for these filetypes
  au FileType pandoc,markdown,tex setlocal spell
  au FileType pandoc,markdown,tex setlocal tw=80

  " Always use tabs
  au FileType gitconfig setlocal noexpandtab
  au FileType go setlocal noexpandtab

augroup END
