DIR="./"

find "$DIR" -type f \( -name "*.aux" -o -name "*.fdb_latexmk" -o -name "*.fls" -o -name "*.log" -o -name "*.gz" -o -name "*.nav" -o -name "*.out" -o -name "*.vrb" -o -name "*.toc" -o -name "*.snm" -o -name "*.xml" -o -name "*.blg" -o -name "*.bcf" -o -name "*.bbl" -o -name "*.bak" -o -name "*Notes.bib" \) -exec rm -f {} \;
