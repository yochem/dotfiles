return {
	'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
	version = 'main',
	event = { 'BufReadPost', 'BufNewFile' },
	config = function()
		local keymaps = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["aC"] = "@class.outer",
			["iC"] = "@class.inner",
			["ab"] = "@block.outer",
			["ib"] = "@block.inner",
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
			["as"] = "@statement.outer",
			["ic"] = "@comment.inner",
			["ac"] = "@comment.outer",
		}
		local ts = require("nvim-treesitter-textobjects.select")
		for rhs, object in pairs(keymaps) do
			vim.keymap.set({ 'x', 'o' }, rhs, function()
				ts.select_textobject(object, "textobjects")
			end)
		end
	end
}
