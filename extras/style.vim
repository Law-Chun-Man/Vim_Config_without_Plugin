"set mode name
function! GetMode()
  let l:dict = {
        \ 'n': 'Normal',
        \ 'i': 'Insert',
        \ 'v': 'Visual',
        \ 'V': 'V-Line',
        \ "\<C-v>": 'V-Block',
        \ "s": 'Select',
        \ "S": 'S-Line',
        \ "\<C-s>": 'S-Block',
        \ 'R': 'Replace',
        \ 'c': 'Command',
        \ 't': 'Terminal',
        \ }
  return get(l:dict, mode(), 'Unknown')
endfunction

"statusline colour
hi Statusline guifg=#441144 guibg=#000000
hi StatusLineMode guifg=#000000 guibg=#00ff00 gui=bold
hi StatusLineFile guifg=#FFFFFF guibg=#771177 gui=bold
hi StatusLineNormal guifg=#FFFFFF guibg=#441144 gui=bold
hi StatusLineWord guifg=#FFFFFF guibg=#441144 gui=bold
hi StatusLinePos guifg=#FFFFFF guibg=#441144 gui=bold
hi StatusLinePercent guifg=#FFFFFF guibg=#441144 gui=bold

"tab colours
hi TabLine guifg=#ffffff guibg=#441144
hi TabLineSel guifg=#000000 guibg=#00ff00
hi TabLineFill guifg=#441144 guibg=#441144
hi TabLine gui=NONE
hi TabLineSel gui=NONE

"set initial status line
set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineFile#\ %t\ %#StatusLineNormal#\ %m%=%#StatusLineWord#\ %{wordcount().words}\ words,\ %{wordcount().chars}\ chars\ %#StatusLinePos#\ %l,\ %v\ %#StatusLinePercent#\ %p%%\ 

"set status line for different mode
autocmd ModeChanged * if &modifiable && mode() ==# 'n' | hi StatusLineMode guifg=#000000 guibg=#00FF00 | hi TabLineSel guifg=#000000 guibg=#00FF00 | set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineFile#\ %t\ %#StatusLineNormal#\ %m%=%#StatusLineWord#\ %{wordcount().words}\ words,\ %{wordcount().chars}\ chars\ %#StatusLinePos#\ %l,\ %v\ %#StatusLinePercent#\ %p%%\ | endif
autocmd ModeChanged * if &modifiable && mode() ==# 'i' | hi StatusLineMode guifg=#000000 guibg=#FFA500 | hi TabLineSel guifg=#000000 guibg=#FFA500 | set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineFile#\ %t\ %#StatusLineNormal#\ %m%=%#StatusLineWord#\ %{wordcount().words}\ words,\ %{wordcount().chars}\ chars\ %#StatusLinePos#\ %l,\ %v\ %#StatusLinePercent#\ %p%%\ | endif
autocmd ModeChanged * if &modifiable && mode() ==# 'R' | hi StatusLineMode guifg=#FFFFFF guibg=#FF0000 | hi TabLineSel guifg=FFFFFF guibg=#FF0000 | set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineFile#\ %t\ %#StatusLineNormal#\ %m%=%#StatusLineWord#\ %{wordcount().words}\ words,\ %{wordcount().chars}\ chars\ %#StatusLinePos#\ %l,\ %v\ %#StatusLinePercent#\ %p%%\ | endif
autocmd ModeChanged * if &modifiable && mode() ==# 'v' || mode() ==# 'V' || mode() ==# "\<C-v>" || mode() ==# "s" || mode() ==# "S" || mode() ==# "\<C-s>" | hi StatusLineMode guifg=#000000 guibg=#00FFFF | hi TabLineSel guifg=#000000 guibg=#00FFFF | set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineFile#\ %t\ %#StatusLineNormal#\ %m%=%#StatusLineWord#\ %{wordcount().visual_words}\ words,\ %{wordcount().visual_chars}\ chars\ %#StatusLinePos#\ %l,\ %v\ %#StatusLinePercent#\ %p%%\ | endif

"custom tabline
function! MyTabLine()
    let s = ''
    "Iterate through each tab
    for i in range(1, tabpagenr('$'))
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let bufnr = buflist[winnr - 1]
        let bufname = bufname(bufnr)

        "Highlight current tab differently
        if i == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        "Tab number
        let s .= ' ' . i . '. '

        "Buffer name + modified indicator
        let s .= (bufname != '' ? fnamemodify(bufname, ':t') : '[No Name]')
        if getbufvar(bufnr, '&modified')
            let s .= ' [+]'
        endif

        "Add spacing between tabs
        let s .= ' '
    endfor

    "Fill remaining space
    let s .= '%#TabLineFill#%T'
    return s
endfunction

"Apply custom tabline
set tabline=%!MyTabLine()

"current line highlight colour
hi CursorLine gui=none guibg=#004444
hi Cursorcolumn guibg=#004444

"number and relativenumber set to white
hi CursorLineNr gui=none guifg=#FFFFFF guibg=#004444
hi LineNr guifg=#FFFFFF

"underline wrong words
highlight SpellBad guibg=#ff0000 ctermbg=red

"Visual mode highlight
highlight Visual guibg=#005577 guifg=NONE

"Word suggestions highlight
highlight Pmenu    guifg=#FFFFFF guibg=#004444
highlight PmenuSel guifg=#FFFFFF guibg=#00AAAA

"window separator colour
highlight WinSeparator guifg=None guibg=#ffffff
