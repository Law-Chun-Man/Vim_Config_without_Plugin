input_file="$1"
log_file="${input_file%.tex}.log"
aux_file="${input_file%.tex}.aux"

if [ -f "$aux_file" ]; then
    pdflatex -synctex=1 -interaction=batchmode "$input_file" > /dev/null 2>&1 || grep -E '^(l\.|!)' "$log_file" | sed 's/^l\./Line /'
else
    pdflatex -synctex=1 -interaction=batchmode "$input_file" > /dev/null 2>&1 || grep -E '^(l\.|!)' "$log_file" | sed 's/^l\./Line /'
    biber "${input_file%.tex}.bcf"
    pdflatex -synctex=1 -interaction=batchmode "$input_file" > /dev/null 2>&1 || grep -E '^(l\.|!)' "$log_file" | sed 's/^l\./Line /'
    pdflatex -synctex=1 -interaction=batchmode "$input_file" > /dev/null 2>&1 || grep -E '^(l\.|!)' "$log_file" | sed 's/^l\./Line /'
fi

