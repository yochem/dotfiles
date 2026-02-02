local map = vim.keymap.set

-- <leader>action copies last yank to clipboard
map('n', '<leader>y', function()
	vim.fn.setreg('+', vim.fn.getreg([["]]))
end)

on('TextYankPost', function()
	if vim.v.event.operator == 'y' then
		for i = 9, 1, -1 do -- Shift all numbered registers.
			vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
		end
	end
end)

-- change line with commented previous version as backup
map('n', 'yc', 'yygccp', { remap = true })
map('v', 'yc', 'ygvgcP', { remap = true })

-- discard uninteresting text
map({ 'n', 'v' }, 'c', '"_c')
map('n', 'dd', [[getline(".") == "" ? '"_dd' : 'dd']], { expr = true })
