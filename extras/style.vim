fu! WordCount() abort
  let wc = wordcount()
  if has_key(wc, 'visual_words') && has_key(wc, 'visual_chars')
    retu wc.visual_words . ' words, ' . wc.visual_chars . ' chars'
  el
    retu get(wc, 'words', 0) . ' words, ' . get(wc, 'chars', 0) . ' chars'
  en
endf

"statusline colour
hi Statusline guifg=#000000 guibg=#ffffff gui=bold

"tab colours
hi TabLine guifg=#ffffff guibg=#000000 gui=NONE
hi TabLineSel guifg=#000000 guibg=#ffffff gui=bold

" Set statusline format
se stl=\ %f\ %m\ %r%=%{WordCount()}\ \ %l,\ %v\ \ %p%%\ 

"custom tabline
fu! MyTabLine()
    let s = ''
    for i in range(1, tabpagenr('$'))
        "Start clickable region for tab 'i'
        let s .= '%' . i . 'T'

        "Highlight current tab differently
        if i == tabpagenr()
            let s .= '%#TabLineSel#'
        el
            let s .= '%#TabLine#'
        en

        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let bufnr = buflist[winnr - 1]
        let bufname = bufname(bufnr)

        "Tab number
        let s .= ' ' . i . '. '

        "Buffer name + modified indicator
        let s .= (bufname != '' ? fnamemodify(bufname, ':t') : '[No Name]')
        if getbufvar(bufnr, '&modified')
            let s .= ' [+]'
        en

        "Add spacing between tabs
        let s .= ' '
    endfo

    "Fill remaining space
    let s .= '%#TabLine#%T'
    retu s
endf

"Apply custom tabline
se tal=%!MyTabLine()

"current line highlight colour
hi CursorLine gui=NONE guibg=#333333
hi Cursorcolumn guibg=#333333

"number and relativenumber set to white
hi CursorLineNr gui=NONE guifg=#FFFFFF guibg=#333333
hi LineNr guifg=#FFFFFF

"Visual mode highlight
hi Visual guibg=#666666 guifg=NONE

"window separator colour
hi WinSeparator guifg=NONE guibg=#ffffff

"yanked texts highlight
hi YankHighlight guibg=#ffffff guifg=#000000

"Word suggestions highlight
hi Pmenu    guifg=#ffffff guibg=NONE
hi PmenuSel guifg=#000000 guibg=#ffffff
