local cmd = vim.cmd

-- open file with cursor on last position
cmd [[au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]

-- right filetypes
cmd [[au BufRead,BufNewFile *.md setlocal filetype=markdown]]
cmd [[au BufRead,BufNewFile *.tex setlocal filetype=tex]]
cmd [[au BufRead,BufNewFile *.tmpl setlocal filetype=gohtmltmpl]]
cmd [[au BufRead,BufNewFile *.plt setlocal filetype=prolog]]
cmd [[au BufRead,BufNewFile *.{txt,md} setlocal textwidth=78]]

-- highligt non-ascii blue
cmd [[highlight nonascii guibg=Blue ctermbg=9]]
cmd [[au BufEnter,InsertLeave match nonascii "[^\x00-\x7F]"]]

-- highlight trailing whitespace intrusive red
cmd [[au BufReadPost * highlight ExtraWhitespace ctermbg=red guibg=red]]
cmd [[au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/]]
cmd [[au InsertLeave * match ExtraWhitespace /\s\+$/]]

-- :help for lua files in nvim config dir
local cfgdir = vim.fn.stdpath('config')
cmd("au BufEnter " .. cfgdir .. "/* setlocal keywordprg=:help")
cmd("au BufEnter " .. cfgdir .. "/* setlocal path+=" .. cfgdir .. "/lua/")

-- compile packer after changing file
cmd("au BufWritePost " .. cfgdir .. "/lua/plugins.lua PackerCompile")

if (vim.env.TMUX ~= nil) then
    local fn = vim.fn.expand('%:t')
    fn = fn ~= '' and fn or 'nvim'
    os.execute("tmux rename-window '" .. fn .. "'")
end
