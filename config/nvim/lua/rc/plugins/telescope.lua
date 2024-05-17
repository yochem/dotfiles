return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
	},
	config = function()
		local trouble = require("trouble.providers.telescope")
		local opts = {
			defaults = {
				mappings = {
					i = { ["<c-o>"] = trouble.open_with_trouble },
					n = { ["<c-o>"] = trouble.open_with_trouble },
				},
			},
		}
		require("telescope").setup(opts)
	end,
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files({
					hidden = true,
					preview = false,
				})
			end,
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers({
					preview = false,
					initial_mode = "normal"
				})
			end,
		},
		{
			"<leader>fF",
			function()
				require("telescope.builtin").lsp_document_symbols({
					symbols = {
						"class",
						"function",
						"struct",
					}
				})
			end,
		},
	},
}
