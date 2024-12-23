local map = vim.keymap.set
map("n", "<leader>D", vim.cmd.lopen)
map("n", "<leader>gd", vim.lsp.buf.definition)
map("n", "<leader>r", vim.lsp.buf.references)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>f", vim.lsp.buf.format)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>h", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

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
