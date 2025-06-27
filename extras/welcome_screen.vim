set shortmess+=I

augroup CustomWelcomeScreen
  autocmd!
  autocmd VimEnter * call ShowCustomWelcome()
augroup END

function! ShowCustomWelcome()
  if bufname('%') == '' && &buftype == ''
    enew
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal readonly
    setlocal noswapfile
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal nonu
    setlocal nornu

    let s:welcome_message_raw = [
    \ '',
    \ '',
    \ '',
    \ ' ██████   █████ █████   █████ █████ ██████   ██████',
    \ '░░██████ ░░███ ░░███   ░░███ ░░███ ░░██████ ██████ ',
    \ ' ░███░███ ░███  ░███    ░███  ░███  ░███░█████░███ ',
    \ ' ░███░░███░███  ░███    ░███  ░███  ░███░░███ ░███ ',
    \ ' ░███ ░░██████  ░░███   ███   ░███  ░███ ░░░  ░███ ',
    \ ' ░███  ░░█████   ░░░█████░    ░███  ░███      ░███ ',
    \ ' █████  ░░█████    ░░███      █████ █████     █████',
    \ '░░░░░    ░░░░░      ░░░      ░░░░░ ░░░░░     ░░░░░ ',
    \ '',
    \ '___________________________________________________',
    \ '',
    \ '[n] New file        ',
    \ '[l] Last edited file',
    \ '[f] File explorer   ',
    \ '[r] Recent file     ',
    \ '[e] Open terminal   ',
    \ '[t] New tab         ',
    \ '[q] Quit            ',
    \ ]

    let l:window_width = winwidth(0)
    let s:centered_message = []

    for line in s:welcome_message_raw
      let line_length = strdisplaywidth(line)
      if line_length < l:window_width
        let padding = (l:window_width - line_length) / 2
        let centered_line = repeat(' ', padding) . line
        call add(s:centered_message, centered_line)
      else
        call add(s:centered_message, line)
      endif
    endfor

    call setline(1, s:centered_message)

    noremap <buffer> n :e<Space>
    noremap <buffer> l :normal! '0<CR>
    noremap <buffer> f :Ex<CR>
    noremap <buffer> r :bro o<CR>
    noremap <buffer> e :FloatingTerminal<CR>
    noremap <buffer> t :Texplore<CR>
    noremap <buffer> q :qall<CR>
  endif
endfunction
