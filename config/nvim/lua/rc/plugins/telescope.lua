return {
	"nvim-telescope/telescope.nvim",
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
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
				require("telescope.builtin").buffers()
			end,
		},
		{
			"<leader>fF",
			function()
				require("telescope.builtin").lsp_document_symbols({symbols={
					'class',
					'function',
					'struct',
				}})
			end,
		},
	},
}
