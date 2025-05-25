local augroup = vim.api.nvim_create_augroup('yochem.lsp', {})

vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>h', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method('textDocument/foldingRange') then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldmethod = 'expr'
			vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
		end
		if client and client:supports_method('textDocument/documentColor') then
			vim.lsp.document_color.enable(true, args.buf, { style = 'virtual' })
		end
	end,
	group = augroup,
})

vim.api.nvim_create_autocmd('LspDetach', {
	command = 'setl foldexpr<',
	group = augroup,
})

vim.lsp.config('*', { root_markers = { '.git' } })

vim.lsp.enable({
	'arduinols',
	'bashls',
	'clangd',
	'gopls',
	'jqls',
	'luals',
	'marksman',
	'pyls',
	'tapo',
	'tinymist',
	'v-analyzer',
	'vscode-cssls',
	'vscode-eslintls',
	'vscode-htmlls',
	'vscode-jsonls',
})
