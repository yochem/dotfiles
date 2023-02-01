return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	event = "InsertEnter",
	config = function()
		require("nvim-treesitter.configs").setup({
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
	end,
	cond = function()
		return vim.api.nvim_buf_line_count(0) < 10000
	end,
}
