vim.keymap.set('n', ']h', '<Cmd>Gitsigns next_hunk<CR>')
vim.keymap.set('n', '[h', '<Cmd>Gitsigns prev_hunk<CR>')
require('gitsigns').setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "│" },
		untracked = { text = "│" },
	},
})
