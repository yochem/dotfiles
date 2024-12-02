if vim.g.vscode then
	return
end
vim.loader.enable()
vim.g.mapleader = " "

vim.cmd.colorscheme("mine")

require("rc.lazy")
require("rc.options")
require("rc.remaps")
require("rc.autocommands")

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.INFO] = "●",
			[vim.diagnostic.severity.HINT] = "●",
		},
	},
	underline = false,
	virtual_text = false,
	update_in_insert = false,
	severity_sort = true,
})

vim.diagnostic.handlers.loclist = {
	show = function(_, _, _, opts)
		opts.loclist.open = opts.loclist.open or false
		local winid = vim.api.nvim_get_current_win()
		vim.diagnostic.setloclist(opts.loclist)
		vim.api.nvim_set_current_win(winid)
	end
}
