"remove search highlight
nnoremap <Esc> :noh <CR>
nnoremap <C-[> :noh <CR>

"move selected texts
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"paste remap
vnoremap p "_dP

"delete whole word
inoremap <C-BS> <C-W>
inoremap <C-H> <C-W>

"select and replace
vnoremap <leader>r "hy:%s/\V<C-r>=escape(@h, '/\')<CR>//g<Left><Left>

"pressing space+s will toggle spell checking on and off
nnoremap <leader>s :setlocal spell!<CR>

"terminal exit insert mode
tnoremap <C-[> <C-\><C-n>

"suggest file name
inoremap <C-f> <C-x><C-f>

"open new tab
nnoremap <leader>t :Texplore<CR>

"tab shortcuts
for i in range(1, 9)
    execute "nnoremap <leader>" . i . " " . i . "gt"
endfor
