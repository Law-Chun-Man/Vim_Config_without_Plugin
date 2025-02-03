set nu
set rnu
set numberwidth=1
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
syntax enable
set history=500
set encoding=utf-8
set noshowmode
set cmdheight=1
set showcmd
set termguicolors

"set mode name
function! GetMode()
  let l:mode_map = {
        \ 'n': 'Normal',
        \ 'i': 'Insert',
        \ 'v': 'Visual',
        \ 'V': 'V-Line',
        \ "\<C-v>": 'V-Block',
        \ 'R': 'Replace',
        \ 'c': 'Command',
        \ 't': 'Terminal',
        \ }
  return get(l:mode_map, mode(), 'Unknown')
endfunction

hi StatusLineMode guifg=#000000 guibg=#00ff00 gui=bold
hi StatusLineFile guifg=#FFFFFF guibg=#771177 gui=bold
hi StatusLineNormal guifg=#FFFFFF guibg=#332233 gui=bold
hi StatusLineWord guifg=#FFFFFF guibg=#662266 gui=bold
hi StatusLinePos guifg=#FFFFFF guibg=#771177 gui=bold
hi StatusLinePercent guifg=#FFFFFF guibg=#880088 gui=bold

"set initial status line
set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineFile#\ %t\ %#StatusLineNormal#\ %m%=%#StatusLineWord#\ %{wordcount().words}\ words,\ %{wordcount().chars}\ chars\ %#StatusLinePos#\ %l,\ %v\ %#StatusLinePercent#\ %p%%\ 

"set status line for different mode
autocmd ModeChanged * if &modifiable && mode() ==# 'n' | hi StatusLineMode guifg=#000000 guibg=#00FF00 | set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineFile#\ %t\ %#StatusLineNormal#\ %m%=%#StatusLineWord#\ %{wordcount().words}\ words,\ %{wordcount().chars}\ chars\ %#StatusLinePos#\ %l,\ %v\ %#StatusLinePercent#\ %p%%\ | endif
autocmd ModeChanged * if &modifiable && mode() ==# 'i' | hi StatusLineMode guifg=#000000 guibg=#FFA500 | set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineFile#\ %t\ %#StatusLineNormal#\ %m%=%#StatusLineWord#\ %{wordcount().words}\ words,\ %{wordcount().chars}\ chars\ %#StatusLinePos#\ %l,\ %v\ %#StatusLinePercent#\ %p%%\ | endif
autocmd ModeChanged * if &modifiable && mode() ==# 'R' | hi StatusLineMode guifg=#FFFFFF guibg=#FF0000 | set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineFile#\ %t\ %#StatusLineNormal#\ %m%=%#StatusLineWord#\ %{wordcount().words}\ words,\ %{wordcount().chars}\ chars\ %#StatusLinePos#\ %l,\ %v\ %#StatusLinePercent#\ %p%%\ | endif
autocmd ModeChanged * if &modifiable && mode() ==# 'v' || mode() ==# 'V' || mode() ==# "\<C-v>" | hi StatusLineMode guifg=#000000 guibg=#00FFFF | set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineFile#\ %t\ %#StatusLineNormal#\ %m%=%#StatusLineWord#\ %{wordcount().visual_words}\ words,\ %{wordcount().visual_chars}\ chars\ %#StatusLinePos#\ %l,\ %v\ %#StatusLinePercent#\ %p%%\ | endif


"disable autocommenting
autocmd FileType * setlocal formatoptions-=cro

"turn off backups, and check if the file is changed externally
set autoread
au FocusGained,BufEnter * silent! checktime
set nobackup
set noswapfile
set nowb

"avoid truncating words at the end of the line, move cursor to actual neighbour
set wrap
set lbr
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"enable smartcase search
set ignorecase
set smartcase

"indent
set ai
set si

"highlight search
set hlsearch

"highlight while searching
set incsearch

"highlight current line
set cursorline
set cursorcolumn
hi CursorLine gui=none guibg=#004444
hi Cursorcolumn guibg=#004444

"number and relativenumber set to white
hi CursorLineNr gui=none guifg=#FFFFFF guibg=#004444
hi LineNr guifg=#FFFFFF

"Visual mode highlight
highlight Visual guibg=#555555 guifg=NONE

"remove search highlight
nnoremap <Esc> :noh <CR>
nnoremap <C-[> :noh <CR>

"copy to clipboard
set clipboard=unnamedplus

"delete whole word
imap <C-BS> <C-W>
imap <C-H> <C-W>

"scroll text if cursor is near top or bottom edge
set so=5

"set mouse to active
set mouse=a

"don't redraw while executing macros (good performance config)
set lazyredraw

"pressing [s will toggle and untoggle spell checking
let mapleader = "["
map <leader>s :setlocal spell!<CR>
map <leader>n :setlocal nospell<CR>

"count words
map <leader>c g<C-g>

"terminal exit insert mode
tnoremap <C-[> <C-\><C-n>

"run code
map <leader>r :!./r.sh<CR>
autocmd FileType python map <leader>r :!python3 "%"<CR>
autocmd FileType python map <leader>f :!black "%"<CR><CR>
autocmd FileType rust map <leader>r :!cargo run --profile release<CR>
autocmd FileType rust map <leader>f :!rustfmt "%"<CR><CR>
autocmd FileType cpp map <leader>r :!g++ "%" && ./a.out<CR>
autocmd FileType c map <leader>r :!gcc "%" && ./a.out<CR>
"for kitty
map <F22> :!./r.sh<CR>
autocmd FileType python map <F22> :!python3 "%"<CR>
autocmd FileType rust map <F22> :!cargo run --profile release<CR>
autocmd FileType cpp map <F22> :!g++ "%" && ./a.out<CR>
autocmd FileType c map <F22> :!gcc "%" && ./a.out<CR>
"remember to open terminal in directory and open file with vi gg.tex
autocmd BufWritePost *.typ :execute "!typst compile main.typ"
"autocmd BufWritePost *.typ :execute "!typst compile %"
autocmd BufWritePost *.tex :execute "!./compile.sh %"
autocmd VimLeave *.tex :execute "!./clean.sh"
"autocmd BufRead,BufNewFile *.tex map <F11> :!bibtex "%:r.aux"<CR><CR>
autocmd BufRead,BufNewFile *.tex map <F11> :!bibtex "main.aux"<CR><CR>
autocmd BufRead,BufNewFile *.typ,*.tex map <leader>p :!xdg-open "%:r.pdf"<CR><CR>

autocmd BufNewFile,BufRead *.typ set filetype=rust

"this is to immediately render when modified
"autocmd TextChanged,TextChangedI *.typ execute "write | !typst compile %"

