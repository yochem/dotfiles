-- inspired by https://github.com/nullromo/go-up.nvim
local ns = vim.api.nvim_create_namespace('yochem.scrolltop')

local function redraw()
	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

	for _ = 1, vim.api.nvim_win_get_height(0) do
		vim.api.nvim_buf_set_extmark(0, ns, 0, 0, {
			virt_lines = { { { '', 'NonText' } } },
			virt_lines_above = true,
		})
	end
end

local function center_screen()
	vim.cmd.normal({ 'zz', bang = true })

	local curr = vim.fn.line('.')
	local top = vim.fn.line('w0')

	local winheight = vim.api.nvim_win_get_height(0)
	local mid = math.floor(winheight / 2)
	local target = curr - mid
	local offset = top - target

	if offset == 0 then
		return
	end

	local scrollcmd = offset > 0 and '' or ''
	vim.cmd.normal({ ('%d%s'):format(math.abs(offset), scrollcmd), bang = true })
end

-- vim.api.nvim_create_autocmd({ 'WinResized', 'BufEnter', 'TextChanged' }, {
-- 	callback = redraw,
-- 	group = vim.api.nvim_create_augroup('yochem.scrolltop', {}),
-- 	desc = 'virtual toplines',
-- })
--
-- vim.keymap.set('n', 'zz', center_screen, { desc = 'virtual toplines' })
