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
  let l:dict = {
        \ 'n': 'Normal',
        \ 'i': 'Insert',
        \ 'v': 'Visual',
        \ 'V': 'V-Line',
        \ "\<C-v>": 'V-Block',
        \ 'R': 'Replace',
        \ 'c': 'Command',
        \ 't': 'Terminal',
        \ }
  return get(l:dict, mode(), 'Unknown')
endfunction

hi Statusline guifg=#332233 guibg=#000000
hi StatusLineMode guifg=#000000 guibg=#00ff00 gui=bold
hi StatusLineFile guifg=#FFFFFF guibg=#771177 gui=bold
hi StatusLineNormal guifg=#FFFFFF guibg=#441144 gui=bold
hi StatusLineWord guifg=#FFFFFF guibg=#441144 gui=bold
hi StatusLinePos guifg=#FFFFFF guibg=#441144 gui=bold
hi StatusLinePercent guifg=#FFFFFF guibg=#441144 gui=bold

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
highlight Visual guibg=#005577 guifg=NONE

"Word suggestions highlight
highlight Pmenu    guifg=#FFFFFF guibg=#004444
highlight PmenuSel guifg=#FFFFFF guibg=#00AAAA
set pumheight=10

"remove search highlight
nnoremap <Esc> :noh <CR>
nnoremap <C-[> :noh <CR>

" move selected texts
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" paste remap
vnoremap p "_dP

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

let mapleader = " "

" select and replace
vnoremap <leader>r "hy:%s/\V<C-r>=escape(@h, '/\')<CR>//g<Left><Left>

"check spellings for files that will contain texts
autocmd BufRead,BufNewFile *.txt,*.tex,*.md,*.html setlocal spell spelllang=en

"pressing space+s will toggle spell checking on and off
nnoremap <leader>s :setlocal spell!<CR>

"terminal exit insert mode
tnoremap <C-[> <C-\><C-n>

"run code
nnoremap <leader>r :!./r.sh<CR>
autocmd FileType python nnoremap <leader>r :!python3 "%"<CR>
autocmd FileType c nnoremap <leader>r :!gcc "%" && ./a.out<CR>
autocmd FileType cpp nnoremap <leader>r :!g++ "%" && ./a.out<CR>

"for terminal
map <F22> :!./r.sh<CR>
autocmd FileType python map <F22> :!python3 "%"<CR>
autocmd FileType c map <F22> :!gcc "%" && ./a.out<CR>
autocmd FileType cpp map <F22> :!g++ "%" && ./a.out<CR>

"compile tex file on save and exit
function! CompileLaTeX() abort
    if filereadable('./main.tex')

        let tex_cmd = '!pdflatex -synctex=1 -interaction=batchmode main.tex > /dev/null 2>&1'
        let log_parse_cmd = '!grep -E "^(l\.|!)" main.log | sed "s/^l\./Line /"'

        if filereadable('./main.aux') "later run
            silent execute tex_cmd
            if v:shell_error
                execute log_parse_cmd
            endif
        else "first run
            silent execute tex_cmd
            if v:shell_error
                execute log_parse_cmd
            endif
            let reference = '!biber main.bcf'
            silent execute reference
            silent execute tex_cmd
            silent execute tex_cmd
        endif
    else

        let file_name = expand('%:r')
        let tex_cmd = '!pdflatex -synctex=1 -interaction=batchmode ' . file_name . '.tex > /dev/null 2>&1'
        let log_parse_cmd = '!grep -E "^(l\.|!)" ' . file_name . '.log | sed "s/^l\./Line /"'

        if filereadable('./' . file_name . '.aux') "later run
            silent execute tex_cmd
            if v:shell_error
                execute log_parse_cmd
            endif
        else "first run
            silent execute tex_cmd
            if v:shell_error
                execute log_parse_cmd
            endif
            let reference = '!biber ' . file_name . '.bcf'
            silent execute reference
            silent execute tex_cmd
            silent execute tex_cmd
        endif
    endif
endfunction

autocmd BufWritePost *.tex call CompileLaTeX()

"clean helper files on leave
autocmd VimLeave *.tex :execute '!find "./" -type f \( -name "*.aux" -o -name "*.fdb_latexmk" -o -name "*.fls" -o -name "*.log" -o -name "*.gz" -o -name "*.nav" -o -name "*.out" -o -name "*.vrb" -o -name "*.toc" -o -name "*.snm" -o -name "*.xml" -o -name "*.blg" -o -name "*.bcf" -o -name "*.bbl" -o -name "*.bak" -o -name "*Notes.bib" \) -exec rm -f {} \;'

"shortcut for opening pdf file
function! PDF() abort
    if filereadable('./main.tex')
        let pdf = './main.pdf'
    else
        let pdf = './' . expand('%:r') . '.pdf'
    endif
    let command = '!atril ' . pdf . ' &'
    execute command
endfunction

"open latex pdf
autocmd BufRead,BufNewFile *.tex map <leader>p :call PDF()<CR><CR>

"render markdown as pdf
autocmd FileType markdown nnoremap <leader>r :!pandoc "%" -o "%:r".pdf<CR><CR>

function! CompileMarkdown() abort
    let pdf = './' . expand('%:r') . '.pdf'
    if filereadable(pdf)
        let command = '!pandoc ' . expand('%:t') . ' -o ' . expand('%:r') . '.pdf'
        execute command
    endif
endfunction
autocmd BufWritePost *.md :call CompileMarkdown()

"open markdown pdf
autocmd FileType markdown map <leader>p :!atril "%:r".pdf &<CR><CR>

