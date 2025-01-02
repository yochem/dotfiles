return {
	"folke/trouble.nvim",
	opts = {
		focus = false,
		warn_no_results = false,
		modes = {
			symbols = {
				format = "{kind_icon} {symbol.name}",
				multiline = false,
			}
		},
	},
	keys = {
		{ "gO", "<Cmd>Trouble symbols<CR>" },
	},
	cmd = "Trouble",
}
