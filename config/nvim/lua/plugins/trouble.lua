return {
	"https://github.com/folke/trouble.nvim",
	main = 'trouble',
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
