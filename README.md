# Neovim Config with LSP but without Plugin

I like default colour scheme btw, don't judge me:). The `terminal.lua` is copied from Radley's [nvim-lite](https://github.com/radleylewis/nvim-lite).

## Dependencies

* NVIM >= v0.7.0
```bash
sudo apt install neovim
```
* pylsp
```bash
sudo apt install python3-pylsp
```
* clangd
```bash
sudo apt install clangd
```
* pandoc
```bash
sudo apt install pandoc
```

## Spell Check

Spell check will be on by default when you open files with extention `.txt`, `.tex`, `.md` and `.html`.

## Custom keybindings

| mode | key | function |
|:---:|:---:|:---:|
| Normal | ctrl+space | list suggestions from LSP |
| Normal | space+s | toggle spell checking on and off |
| Normal | space+p | open pdf of the same name (if there is one) |
| Normal | space+r | compile and run C/C++ code or run python code or compile latex/markdown to pdf |
| Normal | space+h | show a list of keybindings that are useful but rarely mentioned |
| Normal | space+e | open terminal |
| Normal | space+t | open new tab |
| Normal | space+o | find file and open in new tab |
| Normal | space+number | go to tab number |
| Normal | K | popup preview |
| Normal | F2 | rename a variable |
| Normal | ctrl+n | open new tab |
| Insert | ctrl+backspace | delete whole word |
| Visual | J | move selected text downward |
| Visual | K | move selected text upward |
| Visual | space+r | replace selected texts globally |

## Latex keybindings

| mode | key | function |
|:---:|:---:|:---:|
| Insert | ;; | jump to next <++> |
| Insert | ;m | set up mathrm |
| Insert | ;e | set up equations |
| Insert | ;a | set up aligned equations |
| Insert | ;l | set up list |
| Insert | ;t | set up table |
| Insert | ;f | set up figure |
| Insert | ;c | set up columns |
| Insert | ;n | set up new frame |
| Insert | ;b | set up block |


## Custom function
### Latex

* Reference bibtex on the first run
* Compile latex on save
* Clean up helper files on exit

### Markdown

* Compile markdown on save only when there is a pdf file with the same name as the markdown file in the same directory

## Screenshots

* C variable suggestions popup

![normal mode](./screenshots/c.png)


* C error hint

![insert mode](./screenshots/error.png)

* numpy function suggestions popup

![visual mode](./screenshots/python.png)
