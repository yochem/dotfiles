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

function Spell2qf()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local qflist = {}
	for lnum, line in ipairs(lines) do
		local badwords = vim.spell.check(line)
		for _, badword in ipairs(badwords) do
			table.insert(qflist, {
				filename = vim.api.nvim_buf_get_name(0),
				lnum = lnum,
				col = badword[3],
				type = 'E',
				text = badword[1],
			})
		end
	end
	vim.fn.setqflist(qflist, 'r')
end
