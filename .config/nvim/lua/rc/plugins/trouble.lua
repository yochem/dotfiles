return {
	"folke/trouble.nvim",
	opts = {
		icons = false,
		use_diagnostic_signs = true,
		fold_open = "",
		fold_closed = "",
		auto_close = true,
		height = 7,
		padding = false,
		auto_preview = false,
	},
	keys = { { "<leader>t", vim.cmd.TroubleToggle } },
}
