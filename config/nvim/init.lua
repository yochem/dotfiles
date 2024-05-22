if vim.g.vscode then
	return
end
vim.loader.enable()
vim.g.mapleader = " "

require("rc.lazy")
require("rc.options")
require("rc.remaps")
require("rc.autocommands")

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local function hl(group, opts)
			vim.api.nvim_set_hl(0, group, opts)
		end
		hl("LineNr", { fg = "NvimLightGray3" })
		hl("CursorLineNr", { fg = "White" })
		hl("CursorLine", { bg = nil })
		hl("FoldColumn", { fg = "NvimLightGray4" })

		hl("Normal", { fg = "White", bg = "none" })
		hl("Function", { fg = "NvimLightBlue" })
		hl("Identifier", { fg = "NvimLightBlue" })
		hl("Delimiter", { fg = "White" })
		hl("Constant", { fg = "NvimLightYellow" })
		hl("Statement", { fg = "NvimLightMagenta" })
		hl("Special", { link = "Constant" })
		hl("@lsp.mod.declaration", { bold = false })
		hl("@string.documentation", { link = "@comment" })
		hl("@comment.todo", { fg = "NvimLightRed", bold = true })

		hl("@constructor.lua", { link = "Delimiter" })
		hl("@constructor.python", { link = "Function" })
		hl("@variable", { fg = "White" })
		hl("@variable.parameter", { fg = "NvimLightCyan" })
	end
})

vim.fn.sign_define("DiagnosticSignError", { text = "●" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "●" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "●" })
vim.fn.sign_define("DiagnosticSignHint", { text = "●" })

vim.cmd.colorscheme("default")
