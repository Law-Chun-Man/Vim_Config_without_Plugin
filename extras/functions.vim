let mapleader = " "

"run code
nnoremap <leader>r :!./r.sh<CR>
autocmd FileType python nnoremap <leader>r :!python3 "%"<CR>
autocmd FileType c nnoremap <leader>r :!gcc "%" && ./a.out<CR>
autocmd FileType cpp nnoremap <leader>r :!g++ "%" && ./a.out<CR>

"render markdown as pdf
autocmd FileType markdown nnoremap <leader>r :!pandoc "%" -o "%:r".pdf<CR><CR>

function! CompileMarkdown() abort
    let pdf = './' . expand('%:r') . '.pdf'
    if filereadable(pdf)
        let command = '!pandoc ' . expand('%:t') . ' -o ' . expand('%:r') . '.pdf'
        silent execute command
    endif
endfunction
autocmd BufWritePost *.md :call CompileMarkdown()

"open markdown pdf
autocmd FileType markdown nnoremap <leader>p :!zathura "%:r".pdf &<CR><CR>

"help menu
let help = "mode      key         function\n" .
          \"Normal    ctrl+space  list suggestions from LSP\n" .
          \"Normal    zg          add word to the dictionary\n" .
          \"Normal    zug         remove word from the dictionary\n" .
          \"Normal    z=          view word suggestions for correction\n" .
          \"Normal    ]+s         move to next misspelled word\n" .
          \"Normal    [+s         move to last misspelled word\n" .
          \"Normal    space+s     toggle spell checking on and off\n" .
          \"Normal    space+r     run command\n" .
          \"Normal    space+p     open pdf\n" .
          \"Normal    K           popup preview\n" .
          \"Normal    ctrl+n      open new tab\n" .
          \"Insert    ctrl+x+s    show correct word suggestions\n" .
          \"Insert    ctrl+x+f    show file path suggestions\n" .
          \"Visual    J           move selected texts downward\n" .
          \"Visual    K           move selected texts upward\n" .
          \"Visual    space+r     replace selected texts globally\n" .
          \"\nLaTeX shortcuts\n" .
          \"Insert    ;;          jump to next <++>\n" .
          \"Insert    ;m          set up mathrm\n" .
          \"Insert    ;e          set up equations\n" .
          \"Insert    ;a          set up aligned equations\n" .
          \"Insert    ;l          set up list\n" .
          \"Insert    ;t          set up table\n" .
          \"Insert    ;f          set up figure\n" .
          \"Insert    ;c          set up columns\n" .
          \"Insert    ;n          set up new frame\n" .
          \"Insert    ;b          set up block\n"
nnoremap <leader>h :echo help<CR>
