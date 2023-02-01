vim.g.mapleader = " "

pcall(require, "rc.lazy")
pcall(require, "rc.options")
pcall(require, "rc.remaps")
pcall(require, "rc.autocommands")
pcall(require, "rc.lsp")

vim.cmd.colorscheme("onedark")
