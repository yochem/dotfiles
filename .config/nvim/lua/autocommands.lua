local cmd = vim.cmd

cmd [[au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]

cmd [[au BufRead,BufNewFile *.md setlocal filetype=markdown]]
cmd [[au BufRead,BufNewFile *.tex setlocal filetype=tex]]
cmd [[au BufRead,BufNewFile *.tmpl setlocal filetype=gohtmltmpl]]
cmd [[au BufRead,BufNewFile *.plt setlocal filetype=prolog]]

cmd [[au BufRead,BufNewFile *.{txt,md} setlocal textwidth=78]]
cmd [[au FileType * setlocal formatoptions-=ro]]

-- make scripts runnable
cmd [[au BufWritePost * if getline(1) =~ "^#!" | call setfperm(expand('%'), 'rwxr-xr-x') | endif]]
cmd [[au BufWritePost *.sh silent !chmod +x <afile>]]

-- highligt non-ascii and trailing whitespace
cmd [[highlight nonascii guibg=Blue ctermbg=9]]
cmd [[match nonascii "[^\x00-\x7F]"]]

cmd [[au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red]]
cmd [[au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/]]
cmd [[au InsertLeave * match ExtraWhitespace /\s\+$/]]

-- no line numbers in terminal
cmd [[au TermOpen * setlocal nonumber norelativenumber]]

-- open commit with diff
cmd [[au BufRead,BufNewFile COMMIT_EDITMSG Gdiff]]

-- fix workings of swap files
cmd [[au SwapExists * let v:swapchoice = 'o']]
cmd [[au SwapExists * echoerr 'Found a swapfile, opening read-only']]

cmd [[au BufWritePost plugins.lua PackerInstall]]

cmd [[au ColorScheme * call onedark#set_highlight("Normal",{"bg":{"gui":"#1c1c1c","cterm":"235","cterm16": "0"}})]]
