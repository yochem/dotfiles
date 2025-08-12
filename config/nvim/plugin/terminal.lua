local augroup = vim.api.nvim_create_augroup('yochem.terminal', {})

on('TermOpen', 'setl signcolumn=auto', { group = augroup })
on('TermOpen', 'startinsert', { group = augroup })

on('TermRequest', function(ev)
	local seq = ev.data.sequence
	-- OSC0, OSC1, OSC2 set terminal title
	if seq:match('\027%][012];') then
		vim.defer_fn(function()
			if vim.b.term_title then
				vim.api.nvim_buf_set_name(ev.buf, vim.b.term_title)
			end
		end, 50)
	end
end, {
	group = augroup,
	desc = 'set terminal buffer name to terminal title',
})

on('TermRequest', function(ev)
	local ns = vim.api.nvim_create_namespace('yochem.terminal.prompt')
	-- :h terminal-osc133
	if string.match(ev.data.sequence, '^\027]133;A') then
		local lnum = ev.data.cursor[1]
		vim.api.nvim_buf_set_extmark(ev.buf, ns, lnum - 1, 0, {
			sign_text = '▶',
			sign_hl_group = 'SpecialChar',
		})
	end
end, {
	group = augroup,
	desc = 'show sign at terminal prompts',
})
