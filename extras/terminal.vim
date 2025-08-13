autocmd TermOpen * cal chansend(b:terminal_job_id, "clear\n") | start
autocmd TermOpen * setl nonu nornu

tno <Esc> <C-\><C-n>
nn <leader>e :60vsplit \| te<CR>
