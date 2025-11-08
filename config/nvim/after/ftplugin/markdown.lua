vim.opt.listchars:remove("multispace")

local map = vim.keymap.set
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.wo.conceallevel = 2

map("n", "<leader>x", function()
	local line = vim.api.nvim_get_current_line()

	if line:find("- [ ]", 1, true) then
		line = line:gsub("- %b[]", "- [x]")
		vim.api.nvim_set_current_line(line)
	elseif line:find("- [x]", 1, true) then
		line = line:gsub("- %b[]", "- [ ]")
		vim.api.nvim_set_current_line(line)
	end
end)

vim.o.foldlevel = 99

map("n", "~", function()
	local line = vim.api.nvim_get_current_line()
	local new_line

	if line:find("~") then
		new_line = line:gsub("~", "")
	else
		new_line = line:gsub("- (.+)", "- ~%1~")
	end

	vim.api.nvim_set_current_line(new_line)
end, { desc = "Toggle strikethrough" })
