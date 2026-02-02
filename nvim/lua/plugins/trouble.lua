require('trouble').setup({
		focus = false,
		warn_no_results = false,
		modes = {
			symbols = {
				format = '{kind_icon} {symbol.name}',
				multiline = false,
			}
		},
	})

vim.keymap.set('n', 'gO', '<Cmd>Trouble symbols<CR>')
