return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufWinEnter",
	opts = {
		filetype_exclude = { "help", "man", "packer" },
		show_trailing_blankline_indent = false,
	},
	cond = function()
		return vim.api.nvim_buf_line_count(0) < 10000
	end,
	dependencies = "nvim-treesitter/nvim-treesitter",
}
