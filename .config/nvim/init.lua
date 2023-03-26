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


local function set_ft_option(ft, option, value)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = ft,
		group = vim.api.nvim_create_augroup('FtOptions', {}),
		desc = ('set option "%s" to "%s" for this filetype'):format(option, value),
		callback = function()
			vim.opt_local[option] = value
		end
	})
end


set_ft_option({'c', 'c++'}, 'commentstring', '# %s')
