return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		defaults = {
			preview = false
		},
		pickers = {
			find_files = { theme = "ivy" },
			live_grep = { theme = "ivy" },
			buffers = { theme = "dropdown" },
		},
	},
	cmd = "Telescope",
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files({ hidden = true })
			end,
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep({ preview = true })
			end,
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers({
					preview = true,
					initial_mode = "normal",
				})
			end,
		},
		{
			"<leader>fF",
			function()
				require("telescope.builtin").lsp_document_symbols({
					preview = true,
					symbols = {
						"class",
						"function",
						"struct",
					},
				})
			end,
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags({ preview = true })
			end,
		},
	},
}
