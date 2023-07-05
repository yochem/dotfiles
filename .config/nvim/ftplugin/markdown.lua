vim.opt.spell = true
vim.opt.spelllang = 'en'

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
