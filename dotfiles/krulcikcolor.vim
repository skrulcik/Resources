" Scott's Vim Colors
" Loosely based on the vim airline theme murmur, at least enough so they look
" okay together

set bg=dark " Once you go black...
set number          " Line numbers
hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "krulcikcolor"

" Palette
"
" COLOR  | TERM  |   HEX   |
" -------|-------|---------|
" Blue   |   26  | #5f87d7 |
" L Blue |   69  | #5f87ff |
" Green  |   35  | #00af5f |
" Orange |  166  | #FF8C00 |
" White  |   15  | #FFFFFF |
" LGray  |  251  | #C6C6C6 |
" MGray  |  243  | #767676 |
" DGray  |  236  | #303030 |
" Black  |    0  | #000000 |

" white on black
hi Normal       guifg=#FFFFFF guibg=#000000                     ctermfg=15 ctermbg=0
hi Directory    guifg=#FFFFFF guibg=#000000                     ctermfg=15 ctermbg=0
hi Underlined   cterm=underline term=underline
" black on light gray
hi Visual       guifg=#000000 guibg=#C6C6C6 gui=reverse,underline    ctermfg=0 ctermbg=251 cterm=reverse,underline

" white on orange
hi ErrorMsg     guifg=#FFFFFF guibg=#FF8C00                     ctermfg=15 ctermbg=166 term=bold
hi WarningMsg   guifg=#FFFFFF guibg=#FF8C00                     ctermfg=15 ctermbg=166
" green on black
hi ModeMsg      guifg=#00af5f ctermfg=35
hi MoreMsg      guifg=#00af5f ctermfg=35
" white on green
hi Todo         guifg=#FFFFFF guibg=#00af5f                     ctermfg=15 ctermbg=35
" white on blue
hi Search       guifg=#FFFFFF guibg=#5f87d7                     ctermfg=15 ctermbg=26 cterm=underline term=underline
hi IncSearch    guifg=#767676 guibg=#5f87d7                     ctermfg=243 ctermbg=26

" medium gray on black
hi Comment guifg=#767676 ctermfg=243 cterm=none
hi Conceal guifg=#767676 guibg=#000000 ctermfg=243 ctermbg=0 cterm=none
hi SpecialComment   guifg=#767676 ctermfg=243 gui=underline cterm=underline term=underline
hi CursorLine guibg=#000000 ctermbg=236 gui=underline cterm=underline term=underline
" green on black
hi Constant     guifg=#00af5f ctermfg=35 cterm=none
hi Identifier   guifg=#00af5f ctermfg=35 cterm=none
hi PreProc      guifg=#00af5f ctermfg=35 cterm=none
hi Special      guifg=#00af5f ctermfg=35 cterm=none
" orange on black
hi Statement    guifg=#FF8C00 ctermfg=166 cterm=none
" blue on black
hi Type         guifg=#5f87d7 ctermfg=26 cterm=none
hi Title        guifg=#5f87d7 ctermfg=26 cterm=none
" light blue on black
hi javaClassTag guifg=#5f87ff ctermfg=69
hi javaInterfaceTag guifg=#5f87ff ctermfg=69
hi cTypeTag guifg=#5f87ff ctermfg=69
hi cEnumTag guifg=#5f87ff ctermfg=69

" medium gray on dark gray
hi LineNr       guifg=#767676 guibg=#303030 ctermfg=243 ctermbg=236
" Dark gray background
hi ColorColumn  guibg=#303030 ctermbg=236
hi NonText      guibg=#303030 ctermbg=236
" Dark gray on light
hi VertSplit    guifg=#303030 guibg=#C6C6C6 ctermfg=236 ctermbg=251

" light gray on dark gray
hi Pmenu        guifg=#C6C6C6 guibg=#303030 ctermfg=251 ctermbg=236
" light gray on orange
hi PmenuSel     guifg=#C6C6C6 guibg=#FF8C00 ctermfg=251 ctermbg=166
" (scroll bar) light gray on orange
hi PmenuSbar    guifg=#C6C6C6 guibg=#FF8C00 ctermfg=251 ctermbg=166
hi PmenuThumb   guifg=#C6C6C6 ctermfg=251
" white on black
hi WildMenu     guifg=#FFFFFF guibg=#000000 ctermfg=15 ctermbg=0

" Green background
hi DiffChange   guibg=#00af5f ctermbg=35
" Orange background
hi DiffChange   guibg=#FF8C00 ctermbg=166
" Orange text
hi DiffText     guifg=#FF8C00 ctermfg=166 gui=underline term=underline
" Red background
hi DiffDelete   guibg=#800000 ctermbg=1

" Spellcheck
" Underline and make medium gray
hi clear SpellBad
hi SpellBad     guisp=#FF8C00 gui=undercurl ctermfg=243 cterm=undercurl term=undercurl

