vim.api.nvim_create_augroup("rc", {})
local function autocmd(event, opts)
	opts = vim.tbl_extend("keep", opts, { group = "rc" })
	vim.api.nvim_create_autocmd(event, opts)
end

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200, higroup = "Visual" })
	end,
})

-- open file with cursor on last position
autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, [["]])
		if 0 < mark[1] and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

autocmd({ "BufEnter", "BufWritePost", "FocusGained" }, {
	callback = function()
		if vim.env.TMUX ~= nil then
			local fn = vim.fn.expand("%:t")
			fn = fn ~= "" and fn or "nvim"
			os.execute("tmux rename-window '" .. fn .. "'")
		end
	end,
	desc = "rename tmux window to current filename",
})

vim.api.nvim_create_user_command("Scratch", function()
	vim.cmd.new()
	vim.opt_local.buftype = "nofile"
	vim.opt_local.bufhidden = "hide"
	vim.opt_local.swapfile = false
	vim.cmd.startinsert()
end, {})

vim.api.nvim_create_user_command("Config", function()
	vim.cmd.edit(vim.fn.stdpath("config"))
end, {})

-- https://github.com/asrul10/readable-number.nvim
vim.api.nvim_create_user_command("SplitNum", function()
	local curr = vim.fn.expand("<cword>")

	if tonumber(curr) then
		if #curr < 3 then
			return
		end
		local formatted = ""
		for i = #curr, 1, -3 do
			if i - 3 <= 0 then
				formatted = curr:sub(1, i) .. formatted
				break
			end
			formatted = "_" .. curr:sub(i - 2, i) .. formatted
		end
		vim.api.nvim_set_current_line(vim.fn.substitute(vim.fn.getline("."), curr, formatted, ""))
	end
end, {})

return {
	autocmd = autocmd,
}
