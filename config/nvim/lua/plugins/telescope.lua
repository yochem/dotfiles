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
	init = function()
		local map = vim.keymap.set
		local function ts_func(func, args)
			return function() require("telescope.builtin")[func](args) end
		end
		map("n", "<leader>ff", ts_func("find_files"))
		map("n", "<leader>fg", ts_func("live_grep"))
		map("n", "<leader>fb", ts_func("buffers"))
		map("n", "<leader>fF", ts_func("lsp_document_symbols"))
		map("n", "<leader>fh", ts_func("help_tags"))
		map("n", "<leader>fq", ts_func("quickfix"))
		map("n", "<leader>fd", ts_func("find_files", { cwd = vim.fn.stdpath("config") }))
	end
}
