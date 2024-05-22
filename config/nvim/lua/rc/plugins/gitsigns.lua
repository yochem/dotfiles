return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost" },
	opts = {
		signs = {
			add          = { text = "│" },
			change       = { text = "│" },
			delete       = { text = "_" },
			topdelete    = { text = "‾" },
			changedelete = { text = "│" },
			untracked    = { text = "│" },
		},
	}
}
