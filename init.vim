set nu
set rnu
set numberwidth=1
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
syntax on
set history=500
set encoding=utf-8
set noshowmode
set cmdheight=1
set showcmd
set termguicolors
set splitright
set splitbelow

"disable autocommenting
autocmd FileType * setlocal formatoptions-=cro

"turn off backups, and check if the file is changed externally
set autoread
au FocusGained,BufEnter * silent! checktime
set nobackup
set noswapfile
set nowb

"avoid truncating words at the end of the line
set wrap
set lbr

"enable smartcase search
set ignorecase
set smartcase

"indent
set ai
set si

"scroll text if cursor is near top or bottom edge
set so=8

"set mouse to active
set mouse=a

"don't redraw while executing macros (good performance config)
set lazyredraw

"highlight search
set hlsearch

"highlight while searching
set incsearch

"copy to clipboard
set clipboard=unnamedplus

"highlight current line
set cursorline
set cursorcolumn

"check spellings for files that will contain texts
autocmd BufRead,BufNewFile *.txt,*.tex,*.md,*.html setlocal spell spelllang=en

"set max visible word suggestions
set pumheight=10

"lsp
source ~/.config/nvim/extras/lsp.lua

"more vim scripts
source ~/.config/nvim/extras/style.vim
source ~/.config/nvim/extras/functions.vim
source ~/.config/nvim/extras/latex.vim
source ~/.config/nvim/extras/remap.vim
source ~/.config/nvim/extras/netrw.vim
source ~/.config/nvim/extras/terminal.lua
