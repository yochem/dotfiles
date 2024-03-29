vim.opt.spell = true
vim.opt.spelllang = 'en'
vim.opt.formatprg = 'fmt -w 80'

local map = require('rc.remaps').map

map('n', '<leader>x', function ()
	local line = vim.api.nvim_get_current_line()

	if line:find('- [ ]', 1, true) then
		line = line:gsub('- %b[]', '- [x]')
		vim.api.nvim_set_current_line(line)
	elseif line:find('- [x]', 1, true) then
		line = line:gsub('- %b[]', '- [ ]')
		vim.api.nvim_set_current_line(line)
	end
end)

vim.opt.foldlevel = 99

map('n', '~', function ()
	local line = vim.api.nvim_get_current_line()
	local new_line

	if line:find('~') then
		new_line = line:gsub('~', '')
	else
		new_line = line:gsub('- (.+)', '- ~%1~')
	end

	vim.api.nvim_set_current_line(new_line)
end, { desc = 'Toggle strikethrough' })
