vim.keymap.set('n', 'dd', function()
	local qflist = vim.fn.getqflist()
	if #qflist == 0 then
		return
	end

	local idx, _ = unpack(vim.api.nvim_win_get_cursor(0))
	table.remove(qflist, idx)
	vim.fn.setqflist(qflist, 'r')

	if #vim.fn.getqflist() > 0 then
		vim.cmd.crewind({ count = idx })
	else
		vim.cmd.cclose()
	end
end, { desc = 'remove items from the quickfix list', buffer = true })
