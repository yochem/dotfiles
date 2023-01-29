return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	config = function ()
		require('nvim-treesitter.configs').setup({
			highlight = { enable = true },
			indent = { enable = false },
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["ac"] = "@comment.outer",
						["as"] = "@statement.outer",
					},
				},
				move = {
					enable = true,
					goto_next_start = {
						["]f"] = "@function.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
					},
				},
			},
		})
	end
}
