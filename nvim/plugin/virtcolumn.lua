-- stripped down version of lukas-reineke/virt-column.nvim
local ns = vim.api.nvim_create_namespace('yochem.virtcolumn')
local column = 80

vim.api.nvim_set_decoration_provider(ns, {
	on_win = function(_, win, buf, topline, botline)
		if vim.bo[buf].buftype ~= "" then return false end
		vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
		local leftcol = vim.api.nvim_win_call(win, vim.fn.winsaveview).leftcol or 0
		local i = topline
		while i <= botline + 1 do
			local width = vim.api.nvim_win_call(win, function()
				return vim.fn.virtcol({ i, "$" }) - 1
			end)
			local tw = vim.api.nvim_get_option_value('textwidth', { scope = 'local', buf = buf }) + 1
			if width < tw then
				vim.api.nvim_buf_set_extmark(buf, ns, math.max(i - 1, 0), 0, {
					virt_text = { { "│", "NonText" } },
					virt_text_pos = "overlay",
					hl_mode = "combine",
					virt_text_win_col = tw -1 - leftcol,
					priority = 1,
				})
			end
			i = i + 1
		end
	end
})
