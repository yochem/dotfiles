vim.keymap.set('n', '<leader>A', function()
	vim.cmd.args()
end)

local function wrap(step)
	local max = vim.fn.argc()
	if max == 0 then
		return
	end
	local i = vim.fn.argidx()
	vim.cmd.argument({ count = ((i + step) % max + max) % max + 1 })
end

vim.keymap.set('n', '[a', function()
	wrap(-vim.v.count1)
	vim.cmd.args()
end)

vim.keymap.set('n', ']a', function()
	wrap(vim.v.count1)
	vim.cmd.args()
end)

vim.keymap.set('n', '[A', function()
	vim.cmd.first()
	vim.cmd.args()
end)

vim.keymap.set('n', ']A', function()
	vim.cmd.last()
	vim.cmd.args()
end)

vim.keymap.set('n', 'ga', function()
	vim.cmd({ cmd = 'argument', count = vim.v.count ~= 0 and vim.v.count or nil })
	vim.cmd.args()
end)

vim.keymap.set('n', '<leader>aa', function()
	vim.cmd('$argedit %')
	vim.cmd.argdedupe()
	vim.cmd.args()
end)

vim.keymap.set('n', '<leader>ad', function()
	vim.cmd.argdelete('%')
	vim.cmd.args()
end)

vim.keymap.set('n', '<leader>ac', function()
	vim.cmd('%argdelete')
	vim.cmd.args()
end)
