local function negate()
	local negates = {
		['true'] = 'false',
		['false'] = 'true',
		['True'] = 'False',
		['False'] = 'True',
		['0'] = '1',
		['1'] = '0',
		['on'] = 'off',
		['off'] = 'on',
	}

	-- get the entire word under cursor by moving to front and end
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line = cursor[1] - 1
	vim.cmd('exe "norm! wb"')
	local begin_word = vim.api.nvim_win_get_cursor(0)[2]
	vim.cmd('exe "norm! e"')
	local end_word = vim.api.nvim_win_get_cursor(0)[2] + 1

	local word = vim.api.nvim_buf_get_text(0, line, begin_word, line, end_word, {})[1]

	if negates[word] ~= nil then
		vim.api.nvim_buf_set_text(0, line, begin_word, line, end_word, { negates[word] })
	end

	-- restore cursor position
	vim.api.nvim_win_set_cursor(0, cursor)
end

vim.keymap.set('n', '<Plug>(Negate)', negate, {
	desc = 'negate boolean values under cursor'
})
