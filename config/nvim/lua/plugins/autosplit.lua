return {
	"yochem/autosplit.nvim",
	init = function()
		vim.api.nvim_set_keymap("c", ":sp", "Split", {})
		vim.api.nvim_set_keymap("c", ":vs", "Split", {})
	end,
	cmd = "Split",
	opts = {},
}
