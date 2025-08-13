"remove search highlight
nn <Esc> :noh <CR>
nn <C-[> :noh <CR>

"move selected texts
vn J :m '>+1<CR>gv=gv
vn K :m '<-2<CR>gv=gv

"delete whole word
ino <C-BS> <C-W>
ino <C-H> <C-W>

"select and replace
vn <leader>r "hy:%s/\V<C-r>=escape(@h, '/\')<CR>//g<Left><Left>

"pressing space+s will toggle spell checking on and off
nn <leader>s :se spell!<CR>

"suggest correct words
ino <C-s> <C-x><C-s>

"suggest file name
ino <C-f> <C-x><C-f>

"move between split windows
nn <C-h> <C-w>h
nn <C-j> <C-w>j
nn <C-k> <C-w>k
nn <C-l> <C-w>l

"remap e to tabe
cabbrev e tabe

"open new tab
nn <leader>t :Te<CR>

"open new split
nn <leader>v :Ve!<CR>

"tab shortcuts
for i in range(1, 9)
    exe "nn <A-" . i . "> " . i . "gt"
endfo
