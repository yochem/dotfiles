return {
	dir = "~/Documents/autosplit.nvim",
	init = function()
		vim.cmd.cabbrev({ "sp", "Split" })
		vim.cmd.cabbrev({ "vs", "Split" })
	end,
	opts = {},
}