let mapleader = " "

"run code
nn <leader>r :!./r.sh<CR>
autocmd FileType python nn <leader>r :!python3 "%"<CR>
autocmd FileType c nn <leader>r :!gcc "%" && ./a.out<CR>
autocmd FileType cpp nn <leader>r :!g++ "%" && ./a.out<CR>

"auto compile suckless software
autocmd BufRead,BufNewFile config.def.h nn <leader>r :!sudo rm config.h && sudo make clean install<CR>

"render markdown as pdf
autocmd FileType markdown nn <leader>r :!pandoc "%" -o "%:r".pdf<CR><CR>

fu! CompileMarkdown() abort
    let pdf = './' . expand('%:r') . '.pdf'
    if filereadable(pdf)
        let command = '!pandoc ' . expand('%:t') . ' -o ' . expand('%:r') . '.pdf'
        sil exe command
    en
endf
autocmd BufWritePost *.md :cal CompileMarkdown()

"open markdown pdf
autocmd FileType markdown nn <leader>p :!zathura "%:r".pdf &<CR><CR>

"flash yanked texts
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * lua vim.highlight.on_yank({higroup='YankHighlight', timeout=200})
augroup END

"help menu
let help = "mode      key           function\n" .
          \"Normal    ctrl+space    list suggestions from LSP\n" .
          \"Normal    zg            add word to the dictionary\n" .
          \"Normal    zug           remove word from the dictionary\n" .
          \"Normal    z=            view word suggestions for correction\n" .
          \"Normal    ]+s           move to next misspelled word\n" .
          \"Normal    [+s           move to last misspelled word\n" .
          \"Normal    space+s       toggle spell checking on and off\n" .
          \"Normal    space+r       run command\n" .
          \"Normal    space+p       open pdf\n" .
          \"Normal    space+e       open terminal\n" .
          \"Normal    K             popup preview\n" .
          \"Normal    space+t       open new tab\n" .
          \"Normal    space+v       open new split\n" .
          \"Normal    alt+number    go to tab number\n" .
          \"Normal    F2            rename a variable\n" .
          \"Insert    ctrl+s        show correct word suggestions\n" .
          \"Insert    ctrl+f        show file path suggestions\n" .
          \"Visual    J             move selected texts downward\n" .
          \"Visual    K             move selected texts upward\n" .
          \"Visual    space+r       replace selected texts globally\n" .
          \"\nLaTeX shortcuts\n" .
          \"Insert    ;;            jump to next <++>\n" .
          \"Insert    ;m            set up mathrm\n" .
          \"Insert    ;e            set up equations\n" .
          \"Insert    ;a            set up aligned equations\n" .
          \"Insert    ;l            set up list\n" .
          \"Insert    ;t            set up table\n" .
          \"Insert    ;f            set up figure\n" .
          \"Insert    ;c            set up columns\n" .
          \"Insert    ;n            set up new frame\n" .
          \"Insert    ;b            set up block\n"
nn <leader>h :echo help<CR>
