return {
	dir = "/tmp/nvim-treesitter-textobjects",
	-- "nvim-treesitter/nvim-treesitter-textobjects",
	main = "nvim-treesitter.configs",
	event = "BufReadPost",
	opts = {
		highlight = { enable = true },
		indent = { enable = false },
		textobjects = {
			select = {
				enable = true,
				keymaps = {
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

					["ir"] = "@return.inner",
					["ar"] = "@return.outer",

					["lhs"] = "@assignment.lhs",
					["rhs"] = "@assignment.rhs",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@tag",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
				},
				goto_next = {
					["]b"] = "@block.outer",
				},
				goto_previous = {
					["[b"] = "@block.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>s"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>S"] = "@parameter.inner",
				},
			},
		},
	},
	cond = function()
		return vim.api.nvim_buf_line_count(0) < 10000
	end,
}
