return {
	"seblj/nvim-echo-diagnostics",
	init = function()
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = require("echo-diagnostics").echo_line_diagnostic,
		})
	end,
	opts = {
		show_diagnostic_number = false,
		show_diagnostic_source = true,
	},
}
