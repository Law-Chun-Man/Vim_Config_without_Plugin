"remove file explorer comments
let g:netrw_banner = 0

"do not remember directory histories
let g:netrw_dirhistmax = 0

"show size of file in human readable format
let g:netrw_sizestyle = "H"

"sort folders first, and case insensitive sorting
"let g:netrw_sort_by = "exten"
let g:netrw_sort_sequence = '[\/]$,*'
let g:netrw_sort_options = "i"

"hide dot files
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"set number and relative number
let g:netrw_bufsettings = 'nu rnu'

"set display style
"let g:netrw_liststyle = 1

augroup netrw_mappings
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nmap <buffer> h -
  nmap <buffer> l <CR>
  nmap <buffer> . gh
  nmap <buffer> t mf
  nmap <buffer> cc R
  nmap <buffer> dd D
  nmap <buffer> ff %
endfunction
