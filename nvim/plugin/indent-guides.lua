local augroup = vim.api.nvim_create_augroup('yochem.indent', {})

local function guides(sw)
	if sw == 0 then
		sw = vim.bo.tabstop
	end
	local char = '┆' .. (' '):rep(sw-1)
	vim.opt_local.listchars:append({ leadmultispace = char })
end

vim.api.nvim_create_autocmd('OptionSet', {
	pattern = 'shiftwidth',
	group = augroup,
	callback = function ()
		guides(vim.v.option_new)
	end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
	group = augroup,
	callback = function (args)
		guides(vim.bo[args.buf].shiftwidth)
	end
})
