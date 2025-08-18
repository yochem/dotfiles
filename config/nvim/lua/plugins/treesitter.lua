on('FileType', function(ev)
	if vim.bo[ev.buf].buftype ~= '' then return end
	local ok, ts = pcall(require, 'nvim-treesitter')
	if ok then
		local ft = vim.bo[ev.buf].filetype
		local is_available = vim.list_contains(ts.get_available(2), ft)
		local is_installed = vim.list_contains(ts.get_installed(), ft)
		if is_available and not is_installed then
			ts.install(ft)
		end
		if is_installed then
			vim.treesitter.start(ev.buf)
			vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end
end)
