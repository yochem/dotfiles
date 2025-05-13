return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
	},
	cond = function()
		return vim.api.nvim_buf_line_count(0) < 10000
	end,
	build = ":TSUpdate",
}
