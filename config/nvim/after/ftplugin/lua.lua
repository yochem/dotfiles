if _G.MiniSplitjoin ~= nil then
	local gen_hook = MiniSplitjoin.gen_hook
	local curly = { brackets = { '%b{}' } }

	-- Add trailing comma when splitting inside curly brackets
	local add_comma_curly = gen_hook.add_trailing_separator(curly)

	-- Delete trailing comma when joining inside curly brackets
	local del_comma_curly = gen_hook.del_trailing_separator(curly)

	-- Pad curly brackets with single space after join
	local pad_curly = gen_hook.pad_brackets(curly)

	vim.b.minisplitjoin_config = {
		split = { hooks_post = { add_comma_curly } },
		join = { hooks_post = { del_comma_curly, pad_curly } },
	}
end

vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.makeprg = 'nvim -ll %'

vim.keymap.set('i', '++', function ()
	local line = vim.fn.getline('.')
	local varname = line:match("(%w+)%s*$")
	vim.fn.setline('.', ('%s= %s + 1'):format(line, varname))
	vim.cmd.norm({ 'A', bang = true })
end, { buffer = true })

vim.keymap.set('i', '+=', function ()
	local line = vim.fn.getline('.')
	local varname = line:match("(%w+)%s*$")
	vim.fn.setline('.', ('%s= %s + '):format(line, varname))
	vim.cmd.norm({ 'A', bang = true })
end, { buffer = true })
