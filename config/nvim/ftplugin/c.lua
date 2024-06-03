vim.bo.formatprg = 'clang-format'

if vim.fn.expand('%:e') == 'c' then
	vim.keymap.set('n', '<leader>h', '<CMD> sp %:r.h<CR>')
else
	vim.keymap.set('n', '<leader>h', '<CMD> sp %:r.c<CR>')
end
