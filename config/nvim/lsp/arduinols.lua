-- go install github.com/arduino/arduino-language-server@0.7.6
return {
	cmd = { 'arduino-language-server' },
	filetypes = { 'arduino' },
	root_markers = { '*.ino' },
	capabilities = {
		textDocument = { semanticTokens = vim.NIL },
		workspace = { semanticTokens = vim.NIL },
	},
}
