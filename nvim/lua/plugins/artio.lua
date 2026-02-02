require('artio').setup({
	opts = {
		use_icons = false,
	},
	mappings = {
		["<C-n>"] = "down",
    ["<C-p>"] = "up",
    ["<CR>"] = "accept",
    ["<ESC>"] = "cancel",
    ["<TAB>"] = "mark",
    ["<C-l>"] = "togglepreview",
    ["<C-q>"] = "setqflistmark",
	},
})

vim.ui.select = require('artio').select
vim.keymap.set("n", "<leader><leader>", "<Plug>(artio-files)")
vim.keymap.set("n", "<leader>fg", "<Plug>(artio-grep)")
vim.keymap.set("n", "<leader>ff", "<Plug>(artio-smart)")
vim.keymap.set("n", "<leader>fh", "<Plug>(artio-helptags)")
vim.keymap.set("n", "<leader>fb", "<Plug>(artio-buffers)")
vim.keymap.set("n", "<leader>f/", "<Plug>(artio-buffergrep)")
