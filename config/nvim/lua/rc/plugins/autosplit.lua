return {
	dir = "~/Documents/autosplit.nvim",
	init = function()
		vim.api.nvim_set_keymap('ca', 'sp', 'Split', {})
		vim.api.nvim_set_keymap('ca', 'vs', 'Split', {})
	end,
	cmd = "Split",
	opts = {},
}
