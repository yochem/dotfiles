return {
	"lukas-reineke/indent-blankline.nvim",
	event = 'BufWinEnter',
	config = {
		filetype_exclude = { "help", "man", "packer" },
		show_first_indent_level = false,
		show_trailing_blankline_indent = false,
	},
	dependencies = "nvim-treesitter/nvim-treesitter"
}
