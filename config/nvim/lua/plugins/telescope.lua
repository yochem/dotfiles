return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		pickers = {
			find_files = {
				theme = "ivy",
				preview = false,
				hidden = true,
			},
			live_grep = {
				theme = "ivy",
			},
			buffers = {
				theme = "dropdown",
				initial_mode = "normal",
			},
			lsp_document_symbols = {
				symbols = {
					"class",
					"function",
					"struct",
				},
			},
		},
	},
	lazy = true,
	cmd = "Telescope",
}
