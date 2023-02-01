return {
	"seblj/nvim-echo-diagnostics",
	config = function()
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				require("echo-diagnostics").echo_line_diagnostic()
			end,
		})
	end,
	opts = {
		show_diagnostic_number = false,
		show_diagnostic_source = true,
	},
}
