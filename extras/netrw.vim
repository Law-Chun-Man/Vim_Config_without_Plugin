"remove file explorer comments
let g:netrw_banner = 0

"show size of file in human readable format
let g:netrw_sizestyle = "H"

"sort folders first, and case insensitive sorting
let g:netrw_sort_sequence = '[\/]$,*'
let g:netrw_sort_options = "i"

"hide dot files
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"set number and relative number
let g:netrw_bufsettings = 'nu rnu'

let g:netrw_liststyle = 1

augroup netrw_mappings
  autocmd!
  autocmd filetype netrw cal NetrwMapping()
augroup END

fu! NetrwMapping()
  nm <buffer> h -
  nm <buffer> l <CR>
  nm <buffer> . gh
  setl bh=wipe
endf
