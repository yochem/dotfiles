if vim.g.vscode then
	return
end
vim.loader.enable()
vim.g.mapleader = " "

pcall(require, "rc.lazy")
pcall(require, "rc.options")
pcall(require, "rc.remaps")
pcall(require, "rc.autocommands")
pcall(require, "rc.lsp")

vim.cmd.colorscheme("onedark")

vim.api.nvim_set_hl(0, "@string.documentation", { link = "@comment" })
vim.api.nvim_set_hl(0, "@function.builtin.v", { link = "@function.v" })
vim.api.nvim_set_hl(0, "@type.builtin.v", { link = "@type.v" })
vim.api.nvim_set_hl(0, "@parameter.v", { link = "@variable.v" })
