local gps = require("nvim-gps")
local function lsp()
	local clients = vim.lsp.get_active_clients()
	if #clients > 0 then
		return "LSP:" .. clients[1].name
	end
	return ""
end

local function wordcount()
	local ft = vim.bo.filetype
	if ft == "markdown" or ft == "text" then
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
					{ "filename", path = 3 },
					{ gps.get_location, cond = gps.is_available },
				},
				lualine_x = { wordcount, "filetype" },
				lualine_y = {
					lsp,
					'require("nvim-lightbulb").get_status_text()',
					"diagnostics",
				},
				lualine_z = { "location" },
			},
		})
	end,
}
