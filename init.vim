se nu
se rnu
se nuw=1
se et
se ts=4
se sw=4
se sts=4
syn on
se enc=utf-8
se sc
se tgc
se spr
se sb
se shm+=I

"search files in subdirectories
se pa+=**

"remove blue ~ in front of empty lines
se fcs=eob:\ 

"disable autocommenting
autocmd FileType * setl formatoptions-=cro

"turn off backups, and check if the file is changed externally
se ar
au FocusGained,BufEnter * sil! checkt
se nobk
se noswf
se nowb

"avoid truncating words at the end of the line
se wrap
se lbr

"enable smartcase search
se ic
se scs

"indent
se ai
se si

"scroll text if cursor is near top or bottom edge
se so=8

"set mouse to active
se mouse=a

"don't redraw while executing macros (good performance config)
se lz

"highlight search
se hls

"highlight while searching
se is

"copy to clipboard
se cb=unnamedplus

"highlight current line
se cul
se cuc

"check spellings for files that will contain texts
autocmd BufRead,BufNewFile *.txt,*.tex,*.md,*.html setl spell spl=en

"set max visible word suggestions
se ph=10

"return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal! g`\"zz" |
    \ en

"lsp
if expand('%:e') =~ 'py\|c\|cpp'
    so ~/.config/nvim/extras/lsp.lua
en

"more vim scripts
so ~/.config/nvim/extras/style.vim
so ~/.config/nvim/extras/functions.vim
so ~/.config/nvim/extras/remap.vim
so ~/.config/nvim/extras/netrw.vim
so ~/.config/nvim/extras/terminal.vim
if expand('%:e') == 'tex'
    so ~/.config/nvim/extras/latex.vim
en
