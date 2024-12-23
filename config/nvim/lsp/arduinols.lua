return {
	cmd = { 'arduino-language-server' },
	filetypes = { 'arduino' },
	root_markers = { '*.ino' },
	capabilities = {
		textDocument = { semanticTokens = vim.NIL },
		workspace = { semanticTokens = vim.NIL },
	},
}
