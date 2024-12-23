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
