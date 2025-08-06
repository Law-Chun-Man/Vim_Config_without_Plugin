augroup TermSettings
  autocmd!
  autocmd TermOpen * call chansend(b:terminal_job_id, "clear\n") | startinsert
augroup END
autocmd TermOpen * setlocal nonumber norelativenumber

tnoremap <Esc> <C-\><C-n>
nnoremap <leader>e :8split \| ter<CR>
