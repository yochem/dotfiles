local cmd = vim.cmd

-- open file with cursor on last position
cmd [[au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]

-- right filetypes
cmd [[au BufRead,BufNewFile *.md setlocal filetype=markdown]]
cmd [[au BufRead,BufNewFile *.tex setlocal filetype=tex]]
cmd [[au BufRead,BufNewFile *.tmpl setlocal filetype=gohtmltmpl]]
cmd [[au BufRead,BufNewFile *.plt setlocal filetype=prolog]]
cmd [[au BufRead,BufNewFile *.{txt,md} setlocal textwidth=78]]

-- if file got shebang, chmod +x it
cmd [[au BufWritePost * if getline(1) =~ "^#!" | call setfperm(expand('%'), 'rwxr-xr-x') | endif]]
cmd [[au BufWritePost *.sh silent !chmod +x <afile>]]

-- highligt non-ascii blue
cmd [[highlight nonascii guibg=Blue ctermbg=9]]
cmd [[au BufEnter,InsertLeave match nonascii "[^\x00-\x7F]"]]

-- highlight trailing whitespace intrusive red
cmd [[au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red]]
cmd [[au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/]]
cmd [[au InsertLeave * match ExtraWhitespace /\s\+$/]]

-- no line numbers in terminal
cmd [[au TermOpen * setlocal nonumber norelativenumber]]

-- open commit with diff
cmd [[au BufRead,BufNewFile COMMIT_EDITMSG Gdiff]]

-- :help for lua files in nvim config dir
local cfgdir = vim.fn.stdpath('config')
cmd("au BufEnter " .. cfgdir .. "/* setlocal keywordprg=:help")
cmd("au BufEnter " .. cfgdir .. "/* setlocal path+=" .. cfgdir .. "/lua/")

-- compile packer after changing file
cmd("au BufWritePost " .. cfgdir .. "/lua/plugins.lua PackerCompile")

-- bg same as terminal
cmd [[au ColorScheme onedark call onedark#set_highlight("Normal",{"bg":{"gui":"#1c1c1c","cterm":"235","cterm16": "0"}})]]

if (vim.env.TMUX ~= nil) then
    cmd [[autocmd BufReadPost,FileReadPost * call system("tmux rename-window '" . expand("%:t") . "'")]]
end
