return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		exclude = {
			filetypes = { "help", "man", "packer" }
		},
		indent = {
			tab_char = '│'
		}
	},
	event = "BufReadPost",
	dependencies = "nvim-treesitter/nvim-treesitter",
}
