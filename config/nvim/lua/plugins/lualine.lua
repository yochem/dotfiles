local function wordcount()
	local ft = vim.bo.filetype
	if ft == "markdown" or ft == "text" or ft == "typst" then
		if vim.fn.wordcount().visual_words then
			return vim.fn.wordcount().visual_words .. " words"
		else
			return vim.fn.wordcount().words .. " words"
		end
	end
	return ""
end

return {
	"nvim-lualine/lualine.nvim",
	event = "BufWinEnter",
	enabled = false,
	config = function()
		local custom_onedark = require("lualine.themes.onedark")
		custom_onedark.normal.b.fg = "#FFFFFF"
		custom_onedark.normal.c.fg = "#FFFFFF"

		require("lualine").setup({
			options = {
				icons_enabled = false,
				component_separators = "|",
				section_separators = "",
				globalstatus = true,
				theme = custom_onedark,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{ "filename", path = 1 },
				},
				lualine_x = { wordcount, "filetype" },
				lualine_y = {
					"require('nvim-lightbulb').get_status_text()",
					{
						"diagnostics",
						sections = { "error", "warn", "info" },
						always_visible = true,
					},
				},
				lualine_z = { "location" },
			},
		})
	end,
	cond = function()
		return vim.api.nvim_buf_line_count(0) < 10000
	end,
}
