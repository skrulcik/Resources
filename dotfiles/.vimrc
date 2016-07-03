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
Plugin 'scrooloose/nerdtree'            " File navigator sidebar
"Plugin 'jistr/vim-nerdtree-tabs'        " NERDTree in all tabs
Plugin 'ctrlpvim/ctrlp.vim'             " Find files
Plugin 'vim-scripts/a.vim'              " Open alternates
Plugin 'airblade/vim-gitgutter'         " Show git diff symbols in gutter
"Plugin 'tpope/vim-fugitive'             " Use git commands without leaving vim

" Code Editing
Plugin 'scrooloose/syntastic'           " Check for syntax errors
Plugin 'szw/vim-tags'                   " Generate tag files
Plugin 'majutsushi/tagbar'              " Display tags
Plugin 'valloric/youcompleteme'         " Autocomplete
Plugin 'ntpeters/vim-better-whitespace' " Strip trailing whitespace
Plugin 'godlygeek/tabular'              " Align CSV files and Markdown tables
Plugin 'HTML-AutoCloseTag'              " Insert closing HTML tags
Plugin 'Raimondi/delimitMate'           " Auto closing



" Syntax
Plugin 'sudar/vim-arduino-syntax'       " Arduino support
Plugin 'vim-jp/vim-cpp'                 " Improved C/C++ highlighting
Plugin 'JulesWang/css.vim'              " CSS Syntax
Plugin 'tpope/vim-git'                  " Better diff/commit highlighting
Plugin 'jez/vim-ispc'                   " Intel SPMD Program Compiler
Plugin 'pangloss/vim-javascript'        " Javascript
Plugin 'sheerun/vim-json'               " JSON, slightly different from js
Plugin 'LaTeX-Box-Team/LaTeX-Box'       " LaTeX
Plugin 'tpope/vim-liquid'               " Liquid templates
Plugin 'plasticboy/vim-markdown'        " Featureful .md support,
                                        "   must be after tabular
Plugin 'othree/nginx-contrib-vim'       " nginx configu files
Plugin 'mitsuhiko/vim-python-combined'  " Python 2 and 3 support
Plugin 'cakebaker/scss-syntax.vim'      " SCSS
Plugin 'keith/swift.vim'                " Swift!
Plugin 'tmux-plugins/vim-tmux'          " Syntax highlighting for tmux config

" Misc
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jez/vim-superman'               " Mostly cuz Jake is proud of this

call vundle#end()

" === General ===
set backspace=indent,eol,start
set encoding=utf-8  " Encode files in UTF-8
set hlsearch        " Highlight all search terms
set ignorecase      " Allows case-insensitive file completion
set incsearch       " Apply search incrementally
set infercase       " Allows case-insensitive file completion
set laststatus=2    " Always show file status
set nobackup        " Fewer annoying files
set noswapfile      " Fewer annoying files
set nowritebackup   " Fewer annoying files
set scrolloff=3     " Keeps a few lines between cursor and edge
set showcmd         " Show multicharacter commands as they are being typed
set showmatch       " Shows current search result
set sidescrolloff=5 " Keeps a few columnns between cursor and edge
set smartcase       " Disallow case-insensitive if capitals are typed
set splitright      " vsplit to the right
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
let mapleader = "," " Set <leader> to be , instead of \
let g:mapleader = ","

" clear hilighting from search
nmap <leader><space> :noh<cr>
" Toggle the sidebar for the plugin NERDTree
nmap <silent> <leader>t :NERDTreeTabsToggle<cr>
" Toggle the sidebar for the plugin tagbar
nmap <silent> <leader>b :TagbarToggle<cr>
" Toggle files with A.vim
nmap <silent> <leader>a :A<cr>

" Switch tabs with ctrl-n and ctrl-m
set switchbuf=usetab
nnoremap <c-m> :sbnext<cr>
nnoremap <c-n> :sbprevious<CR>

" Format the current paragraph
let @f='{)gq}'

" Make navigating long, wrapped lines behave like normal lines
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$
noremap <silent> ^ g^
noremap <silent> _ g_

" Center search result on screen
nmap n nzz
nmap N Nzz

" === Plugin Settings ===

" Built-in vim plugins
let g:netrw_liststyle=3      " When viewing directories, show nested tree mode
let g:netrw_dirhistmax = 0   " Don't create .netrwhist files

" Airline
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
let g:vim_markdown_frontmatter=1
let g:vim_markdown_math=1
let g:vim_markdown_new_list_item_indent=2
let g:vim_markdown_toc_autofit = 1

" Tagbar
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Reconfigure the tagbar for latex
let g:tagbar_type_tex = {
\    'ctagstype' : 'tex',
\    'kinds' : [
\        's:sections',
\        'g:graphics:0:0',
\        'l:labels',
\        'r:refs:1:0',
\        'p:pagerefs:1:0'
\    ],
\    'sort' : 0,
\ }

" git gutter
hi clear SignColumn
" Only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" Better Whitespace
" Don't highlight whitespace in git commit messages (for diffs)...
let g:better_whitespace_filetypes_blacklist=['gitcommit']
" ... but strip it on save so that we're still safe
autocmd FileType gitcommit autocmd BufWritePre <buffer> StripWhitespace

" Tabularize
:abbrev Table Tabularize

" delimitMate - Autocloseable tags
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" vim SuperMan - open up another manpage using 'K'
noremap K :SuperMan <cword><CR>

" Command Summary
" \t = View File Tree
" \b = View Outline
" ctrl+p -> fuzzyfind -> ctrl+t = fuzzy find new tab
" :AV = Open Counterpart/Alternative
" :Tab /<exp> = align on <exp>

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

" === Optional ===
" Those things that are nice, just not all the time

" set background=dark " Always keep a dark background
" set cursorline      " Highlights/underlines current editor line
" set cursorcolumn    " Highlights/underlines current editor column
" set cc=81           " Puts barrier line at 80 columns
set ttyfast         " idk but bezi claims smoother performance
" Trim whitespace on save
nmap <silent> <leader>w :StripWhitespace<cr> :%s/\n\{3,}/\r\r/e<cr> :w<cr>
" Long line handling, maybe do it per filetype
set wrap
set textwidth=79
set formatoptions=qrn1

" === Optional (Plugin) ===
" Uncomment to open tagbar automatically whenever possible
" autocmd BufEnter * nested :call tagbar#autoopen(0)

