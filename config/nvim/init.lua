if vim.g.vscode then
	return
end
vim.loader.enable()
vim.g.mapleader = " "

require("rc.lazy")
require("rc.options")
require("rc.remaps")
require("rc.autocommands")
require("rc.lsp")

vim.cmd.colorscheme("onedark")

vim.api.nvim_set_hl(0, "@string.documentation", { link = "@comment" })
vim.api.nvim_set_hl(0, "@function.builtin.v", { link = "@function.v" })
vim.api.nvim_set_hl(0, "@type.builtin.v", { link = "@type.v" })
vim.api.nvim_set_hl(0, "@parameter.v", { link = "@variable.v" })
vim.cmd('highlight SpellBad guifg=NONE')
