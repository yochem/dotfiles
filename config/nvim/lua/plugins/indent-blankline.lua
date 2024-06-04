return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		scope = { enabled = false },
		exclude = {
			filetypes = { "help", "man", "packer" },
		},
		indent = {
			tab_char = "│",
		},
	},
	event = "VeryLazy",
	dependencies = "nvim-treesitter/nvim-treesitter",
}
