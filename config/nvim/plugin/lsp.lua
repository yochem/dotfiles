local augroup = vim.api.nvim_create_augroup('yochem.lsp', {})

vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>h', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

on('LspProgress', function(ev)
	local value = ev.data.params.value
	if value.kind == 'begin' then
		vim.api.nvim_ui_send('\027]9;4;1;0\027\\')
	elseif value.kind == 'end' then
		vim.api.nvim_ui_send('\027]9;4;0\027\\')
	elseif value.kind == 'report' then
		vim.api.nvim_ui_send(string.format('\027]9;4;1;%d\027\\', value.percentage or 0))
	end
end)

on('LspAttach', function(args)
	local client = vim.lsp.get_client_by_id(args.data.client_id)
	if client and client:supports_method('textDocument/foldingRange') then
		local win = vim.api.nvim_get_current_win()
		vim.wo[win][0].foldmethod = 'expr'
		vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
	end
	if client and client:supports_method('textDocument/documentColor') then
		vim.lsp.document_color.enable(true, args.buf, { style = 'virtual' })
	end
	if client and client:supports_method 'textDocument/codeLens' then
		vim.lsp.codelens.refresh({ bufnr = args.buf })
		vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
			buffer = args.buf,
			callback = function()
				vim.lsp.codelens.refresh({ bufnr = args.buf })
			end,
		})
	end
end, {
	group = augroup,
})

on('LspDetach', 'setl foldexpr<', { group = augroup })

vim.lsp.config('*', { root_markers = { '.git' } })

vim.lsp.enable({
	'arduinols',
	'bashls',
	'clangd',
	'gopls',
	'jqls',
	'luals',
	'marksman',
	'ty',
	'tapo',
	'tinymist',
	'v-analyzer',
	'vscode-cssls',
	'vscode-eslintls',
	'vscode-htmlls',
	-- 'vscode-jsonls',
})
