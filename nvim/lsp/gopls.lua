-- go install -v golang.org/x/tools/gopls@latest
return {
	cmd = { 'gopls' },
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	root_markers = { 'go.mod', '.git' },
}
