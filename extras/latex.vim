"add latex file type
autocmd BufRead,BufNewFile * se ft=tex

"don't indent in latex
se noai nocin nosi inde=

"compile tex file on save and exit
fu! CompileLaTeX() abort
    if filereadable('./main.tex')

        let tex_cmd = '!pdflatex -synctex=1 -interaction=batchmode main.tex > /dev/null 2>&1'
        let log_parse_cmd = '!grep -E "^(l\.|!)" main.log | sed "s/^l\./Line /"'

        if filereadable('./main.aux') "later run
            sil exe tex_cmd
            if v:shell_error
                exe log_parse_cmd
            en
        el "first run
            sil exe tex_cmd
            if v:shell_error
                exe log_parse_cmd
            en
            let reference = '!biber main.bcf'
            sil exe reference
            sil exe tex_cmd
            sil exe tex_cmd
        en
    el

        let file_name = expand('%:r')
        let tex_cmd = '!pdflatex -synctex=1 -interaction=batchmode ' . file_name . '.tex > /dev/null 2>&1'
        let log_parse_cmd = '!grep -E "^(l\.|!)" ' . file_name . '.log | sed "s/^l\./Line /"'

        if filereadable('./' . file_name . '.aux') "later run
            sil exe tex_cmd
            if v:shell_error
                exe log_parse_cmd
            en
        el "first run
            sil exe tex_cmd
            if v:shell_error
                exe log_parse_cmd
            en
            let reference = '!biber ' . file_name . '.bcf'
            sil exe reference
            sil exe tex_cmd
            sil exe tex_cmd
        en
    en
endf

autocmd BufWritePost * cal CompileLaTeX()

"clean helper files on leave
autocmd VimLeave * :exe '!find "./" -type f \( -name "*.aux" -o -name "*.fdb_latexmk" -o -name "*.fls" -o -name "*.log" -o -name "*.gz" -o -name "*.nav" -o -name "*.out" -o -name "*.vrb" -o -name "*.toc" -o -name "*.snm" -o -name "*.xml" -o -name "*.blg" -o -name "*.bcf" -o -name "*.bbl" -o -name "*.bak" -o -name "*Notes.bib" \) -exec rm -f {} \;'

"shortcut for opening pdf file
fu! PDF() abort
    if filereadable('./main.tex')
        let pdf = './main.pdf'
    el
        let pdf = './' . expand('%:r') . '.pdf'
    en
    let command = '!zathura ' . pdf . ' &'
    sil exe command
endf

"open latex pdf
nn <leader>p :cal PDF()<CR>

"shortcuts in latex
ino ;; <Esc>/<++><CR>"_c4l
ino ;m \mathrm{}<Space><++><Esc>F}i
ino ;e \begin{equation}<CR><CR>\end{equation}<Esc>ki
ino ;a \begin{align}<CR><CR>\end{align}<Esc>ki
ino ;l \begin{itemize}<CR>\item<Space><CR>\item<Space><++><CR>\end{itemize}<Esc>2kA
ino ;t \begin{table}[H]<CR>\centering<CR>\caption{}<CR>\begin{tabular}{<++>}<CR>\hline<CR><++><CR>\end{tabular}<CR>\label{<++>}<CR>\end{table}<Esc>6k$i
ino ;f \begin{figure}[H]<CR>\centering<CR>\includegraphics[width=\textwidth]{<++>}<CR>\caption{<++>}<CR>\label{<++>}<CR>\end{figure}<Esc>3k0f=a
ino ;c \begin{columns}<CR>\begin{column}{0.45\textwidth}<CR><CR>\end{column}<CR>\begin{column}{0.45\textwidth}<CR><++><CR>\end{column}<CR>\end{columns}<Esc>5kA
ino ;n \begin{frame}<CR>\frametitle{}<CR><++><CR>\end{frame}<Esc>2k$i
ino ;b \begin{block}{}<CR><++><CR>\end{block}<Esc>2k$i
ino ;/ \frac{}{<++>}<++><Esc>2F}i
ino ;d \frac{\mathrm{d}}{\mathrm{d}<++>}<++><Esc>3F}i
