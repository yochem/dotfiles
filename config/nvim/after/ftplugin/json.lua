vim.bo[0].tabstop = 2
vim.bo[0].shiftwidth = 2

function _G.json_formatter()
	-- from $VIMRUNTIME/lua/vim/lsp.lua
	if vim.list_contains({ 'i', 'R', 'ic', 'ix' }, vim.fn.mode()) then
		return 1
	end
	local indent = vim.bo.expandtab and '\t' or string.rep(' ', vim.o.tabstop)
	vim.print({ indent })

	local lines = vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.count, true)
	local deco = vim.json.decode(table.concat(lines, '\n'))
	local enco = vim.json.encode(deco, { indent = indent })
	local split = vim.split(enco, '\n')
	vim.api.nvim_buf_set_lines(0, vim.v.lnum - 1, vim.v.count, true, split)

	return 0
end

vim.bo.formatexpr = 'v:lua.json_formatter()'
