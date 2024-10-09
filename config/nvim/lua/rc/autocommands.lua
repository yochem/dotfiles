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

-- autocmd("BufReadPost", {
-- 	callback = function(args)
-- 		local git_dirs = vim.fs.find(".git", {
-- 			upward = true,
-- 			path = vim.fs.dirname(args.file),
-- 		})
-- 		if git_dirs[1] ~= nil then
-- 			vim.cmd.lcd(vim.fs.dirname(git_dirs[1]))
-- 			vim.g.project_dir_set = true
-- 		end
-- 	end,
-- 	desc = "use folder with .git folder as root directory",
-- })

vim.api.nvim_create_user_command("Scratch", function()
	vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
		split = "below",
		height = 20,
	})
	vim.cmd.startinsert()
end, {})

autocmd("WinEnter", {
	callback = function()
		local win_width = vim.api.nvim_win_get_width(0)
		local is_float = vim.api.nvim_win_get_config(0).relative ~= ""
		if not is_float and win_width > 160 then
			vim.cmd.wincmd("L")
		end
	end,
	desc = "open second window horizontally",
})
