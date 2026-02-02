vim.env.EXTENSION_ALL = 1
vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('yochem.plugins.treesitter', {}),
	callback = function(ev)
		if vim.bo[ev.buf].buftype ~= '' then return end
		local ts = require('nvim-treesitter')
		local ft = vim.bo[ev.buf].filetype
		local is_available = vim.list_contains(ts.get_available(), ft)
		local is_installed = vim.list_contains(ts.get_installed(), ft)
		if is_available then
			if not is_installed then
				ts.install(ft)
			end
			vim.treesitter.start(ev.buf)
			vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end
})
