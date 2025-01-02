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

autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, [["]])
		if 0 < mark[1] and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
	desc = "open file with cursor on last position",
})

vim.api.nvim_create_user_command("Scratch", function()
	vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
		split = "below",
		height = 20,
	})
	vim.cmd.startinsert()
end, {})

vim.api.nvim_create_user_command("AddPlugin", function(args)
	-- try match repo name from GitHub url
	local user_repo = args.args:match("[^/]+/[^/]+$")
	local name = args.args:match("[^/]+$")
	if not user_repo or not name then
		vim.notify("provide github url as argument, got: " .. args.args, vim.log.levels.ERROR)
		return
	end
	local stripped = name:gsub(".nvim", ""):gsub("nvim-", ""):gsub("-nvim", "")
	local filename = vim.fn.stdpath('config') .. "/lua/plugins/" .. stripped .. ".lua"
	if vim.fn.filereadable(filename) == 1 then
		vim.notify("plugin path already exists: " .. filename, vim.log.levels.ERROR)
		return
	end
	vim.cmd.vsplit(filename)
	vim.api.nvim_buf_set_lines(0, 0, -1, false, { ([[return { "%s" }]]):format(user_repo) })
end, {
	nargs = 1,
	desc = ":AddPlugin https://github.com/user/repo creates lua/plugin/repo.lua"
})
