"remove file explorer comments
let g:netrw_banner = 0

"hide dot files
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"set explorer as welcome screen
autocmd VimEnter * if argc() == 0 | Explore | endif

"set number and relative number
let g:netrw_bufsettings = 'nu rnu'

augroup netrw_mappings
  autocmd!
  autocmd FileType netrw call s:SetupNetrwMappings()
augroup END

function! s:SetupNetrwMappings()
  nmap <buffer> h -
  nmap <buffer> l <CR>
  nmap <buffer> . gh
endfunction
