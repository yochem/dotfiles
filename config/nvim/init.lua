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
	update_in_insert = true,
	severity_sort = true,
})
