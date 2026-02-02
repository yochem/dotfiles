local augroup = vim.api.nvim_create_augroup('yochem.terminal', {})

on('TermOpen', 'setl signcolumn=auto', { group = augroup })
on('TermOpen', 'setl statuscolumn=', { group = augroup })
on('TermOpen', function (ev)
	local chans = vim.api.nvim_list_chans()
	for _, chan in ipairs(chans) do
		if chan.buffer == ev.buf then
			if #chan.argv <= 1 then
				vim.cmd('startinsert')
				return
			end
		end
	end
end, { group = augroup })

-- TODO: doesn't work with multiple terminals
-- on('TermRequest', function(ev)
-- 	local seq = ev.data.sequence
-- 	-- OSC0, OSC1, OSC2 set terminal title
-- 	if seq:match('\027%][012];') then
-- 		vim.defer_fn(function()
-- 			if vim.b.term_title then
-- 				vim.api.nvim_buf_set_name(ev.buf, vim.b.term_title)
-- 			end
-- 		end, 50)
-- 	end
-- end, {
-- 	group = augroup,
-- 	desc = 'set terminal buffer name to terminal title',
-- })

-- |terminal-osc7|
on('TermRequest', function(ev)
	local val, n = string.gsub(ev.data.sequence, '\027]7;file://[^/]*', '')
	if n > 0 then
		-- OSC 7: dir-change
		local dir = val
		if vim.fn.isdirectory(dir) == 0 then
			vim.notify('invalid dir: ' .. dir)
			return
		end
		vim.b[ev.buf].osc7_dir = dir
		if vim.api.nvim_get_current_buf() == ev.buf then
			vim.cmd.lcd(dir)
		end
	end
end)
