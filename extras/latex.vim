"add latex file type
autocmd BufRead,BufNewFile *.tex set filetype=tex

"don't indent in latex
autocmd FileType tex setlocal noautoindent nocindent nosmartindent indentexpr=

"compile tex file on save and exit
function! CompileLaTeX() abort
    if filereadable('./main.tex')

        let tex_cmd = '!pdflatex -synctex=1 -interaction=batchmode main.tex > /dev/null 2>&1'
        let log_parse_cmd = '!grep -E "^(l\.|!)" main.log | sed "s/^l\./Line /"'

        if filereadable('./main.aux') "later run
            silent execute tex_cmd
            if v:shell_error
                execute log_parse_cmd
            endif
        else "first run
            silent execute tex_cmd
            if v:shell_error
                execute log_parse_cmd
            endif
            let reference = '!biber main.bcf'
            silent execute reference
            silent execute tex_cmd
            silent execute tex_cmd
        endif
    else

        let file_name = expand('%:r')
        let tex_cmd = '!pdflatex -synctex=1 -interaction=batchmode ' . file_name . '.tex > /dev/null 2>&1'
        let log_parse_cmd = '!grep -E "^(l\.|!)" ' . file_name . '.log | sed "s/^l\./Line /"'

        if filereadable('./' . file_name . '.aux') "later run
            silent execute tex_cmd
            if v:shell_error
                execute log_parse_cmd
            endif
        else "first run
            silent execute tex_cmd
            if v:shell_error
                execute log_parse_cmd
            endif
            let reference = '!biber ' . file_name . '.bcf'
            silent execute reference
            silent execute tex_cmd
            silent execute tex_cmd
        endif
    endif
endfunction

autocmd BufWritePost *.tex call CompileLaTeX()

"clean helper files on leave
autocmd VimLeave *.tex :execute '!find "./" -type f \( -name "*.aux" -o -name "*.fdb_latexmk" -o -name "*.fls" -o -name "*.log" -o -name "*.gz" -o -name "*.nav" -o -name "*.out" -o -name "*.vrb" -o -name "*.toc" -o -name "*.snm" -o -name "*.xml" -o -name "*.blg" -o -name "*.bcf" -o -name "*.bbl" -o -name "*.bak" -o -name "*Notes.bib" \) -exec rm -f {} \;'

"shortcut for opening pdf file
function! PDF() abort
    if filereadable('./main.tex')
        let pdf = './main.pdf'
    else
        let pdf = './' . expand('%:r') . '.pdf'
    endif
    let command = '!zathura ' . pdf . ' &'
    silent execute command
endfunction

"open latex pdf
autocmd BufRead,BufNewFile *.tex nnoremap <leader>p :call PDF()<CR>

"shortcuts in latex
autocmd FileType tex inoremap ;; <Esc>/<++><CR>"_c4l
autocmd FileType tex inoremap ;m \mathrm{}<Space><++><Esc>F}i
autocmd FileType tex inoremap ;e \begin{equation}<CR><CR>\end{equation}<CR><Esc>2ki
autocmd FileType tex inoremap ;a \begin{align}<CR><CR>\end{align}<CR><Esc>2ki
autocmd FileType tex inoremap ;l \begin{itemize}<CR>\item<Space><CR>\item<Space><++><CR>\end{itemize}<CR><Esc>3kA
autocmd FileType tex inoremap ;t \begin{table}[H]<CR>\centering<CR>\caption{}<CR>\begin{tabular}{<++>}<CR>\hline<CR><++><CR>\end{tabular}<CR>\label{<++>}<CR>\end{table}<CR><Esc>7k$i
autocmd FileType tex inoremap ;f \begin{figure}[H]<CR>\centering<CR>\includegraphics[width=\textwidth]{<++>}<CR>\caption{<++>}<CR>\label{<++>}<CR>\end{figure}<CR><Esc>4k0f=a
autocmd FileType tex inoremap ;c \begin{columns}<CR>\begin{column}{0.45\textwidth}<CR><CR>\end{column}<CR>\begin{column}{0.45\textwidth}<CR><++><CR>\end{column}<CR>\end{columns}<CR><Esc>6kA
autocmd FileType tex inoremap ;n \begin{frame}<CR>\frametitle{}<CR><++><CR>\end{frame}<CR><Esc>3k$i
autocmd FileType tex inoremap ;b \begin{block}{}<CR><++><CR>\end{block}<CR><Esc>3k$i
