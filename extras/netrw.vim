augroup netrw_mappings
  autocmd!
  autocmd FileType netrw call s:SetupNetrwMappings()
augroup END

function! s:SetupNetrwMappings()
  nmap <buffer> h -
  nmap <buffer> l <CR>
  nmap <buffer> . gh
endfunction
