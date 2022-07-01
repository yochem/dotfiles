

vim.keymap.set('n',  '<leader>r', '<cmd>!python3 %:p<CR>', {buffer = true})

vim.opt.formatprg = 'python-format'


-- list all functions in the current buffer, type :<line-num> to jump to it
vim.keymap.set('n', ',f', function ()
	vim.cmd([[
	normal mx
	exe 'g/def .*:$\|^class /#'
	normal `x
	]])
end, {})

-- fold docstrings beautifully
vim.opt_local.foldenable = true
vim.opt_local.fillchars.fold = ' '
vim.opt_local.foldmethod = 'syntax'

vim.opt.autoread = true
vim.keymap.set('n', '<leader>b', '<cmd>!black %<CR>', {buffer = true})
