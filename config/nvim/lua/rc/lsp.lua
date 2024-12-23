vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/foldingRange") then
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
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
	'pyls',
	'tapo',
	'tinymist',
	'v-analyzer',
	'vscode-cssls',
	'vscode-eslintls',
	'vscode-htmlls',
	'vscode-jsonls',
})
