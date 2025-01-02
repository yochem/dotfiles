vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>r', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>h', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)
-- vim.keymap.set('n', 'gO', function ()
-- 	vim.lsp.buf.document_symbol({ loclist = true })
-- end)

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end
		if client:supports_method('textDocument/foldingRange') then
			vim.wo.foldmethod = 'expr'
			vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
		end
	end,
})

vim.lsp.config('*', {
	root_markers = { '.git' },
})

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
