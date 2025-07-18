return {
	"https://github.com/lewis6991/gitsigns.nvim",
	main = 'gitsigns',
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "│" },
			untracked = { text = "│" },
		},
	},
}
