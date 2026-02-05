local augroup = vim.api.nvim_create_augroup('yochem.lsp', {})

vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>h', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

on('LspAttach', function(args)
	local client = vim.lsp.get_client_by_id(args.data.client_id)
	local buf = args.buf
	if not client then
		return
	end
	if client:supports_method('textDocument/foldingRange') then
		local win = vim.api.nvim_get_current_win()
		vim.wo[win][0].foldmethod = 'expr'
		vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
	end
	if client:supports_method('textDocument/documentColor') then
		vim.lsp.document_color.enable(true, buf, { style = 'virtual' })
		vim.api.nvim_buf_create_user_command(buf, 'ColorRepresentation', vim.lsp.document_color.color_presentation, {})
	end
	if client:supports_method('textDocument/codeLens') then
		vim.lsp.codelens.enable(true, { bufnr = buf })
		vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
			buffer = buf,
			group = augroup,
			callback = function()
				vim.lsp.codelens.enable(true, { bufnr = buf })
			end,
		})
	end

	-- if client:supports_method 'textDocument/documentHighlight' then
	-- 	vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
	-- 		group = augroup,
	-- 		desc = 'Highlight references under the cursor',
	-- 		buffer = args.buf,
	-- 		callback = vim.lsp.buf.document_highlight,
	-- 	})
	-- 	vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
	-- 		group = augroup,
	-- 		desc = 'Clear highlight references',
	-- 		buffer = args.buf,
	-- 		callback = vim.lsp.buf.clear_references,
	-- 	})
	-- end
end, {
	group = augroup,
})

vim.api.nvim_create_autocmd('LspDetach', {
	group = augroup,
	command = 'setl foldexpr<',
})

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
	once = true,
	group = augroup,
	callback = function()
		vim.lsp.config('*', {
			capabilities = require('blink.cmp').get_lsp_capabilities(nil, true),
			root_markers = { '.git' },
		})

		local files = vim.api.nvim_get_runtime_file('lsp/*.lua', true)
		local servers = vim.iter(files):map(function(f)
			return vim.fn.fnamemodify(f, ':t:r')
		end):totable()
		vim.lsp.enable(servers)
	end,
})
