return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufWinEnter",
	opts = {
		filetype_exclude = { "help", "man", "packer" },
		show_trailing_blankline_indent = false,
	},
	dependencies = "nvim-treesitter/nvim-treesitter",
}
