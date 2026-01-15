local keymaps = {
	['af'] = '@function.outer',
	['if'] = '@function.inner',
	['aC'] = '@class.outer',
	['iC'] = '@class.inner',
	['ab'] = '@block.outer',
	['ib'] = '@block.inner',
	['aa'] = '@parameter.outer',
	['ia'] = '@parameter.inner',
	['as'] = '@statement.outer',
	['ic'] = '@comment.inner',
	['ac'] = '@comment.outer',
}

for rhs, object in pairs(keymaps) do
	vim.keymap.set({ 'x', 'o' }, rhs, function()
		local ts_select = require('nvim-treesitter-textobjects.select')
		ts_select.select_textobject(object, 'textobjects')
	end)
end

vim.keymap.set('n', '[f', function()
	local ts_move = require('nvim-treesitter-textobjects.move')
	ts_move.goto_previous_start('@function.outer', 'textobjects')
end)
vim.keymap.set('n', ']f', function()
	local ts_move = require('nvim-treesitter-textobjects.move')
	ts_move.goto_next_start('@function.outer', 'textobjects')
end)
