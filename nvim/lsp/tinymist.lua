-- brew install tinymist
return {
	cmd = { 'tinymist' },
	filetypes = { 'typst' },
	root_markers = { '*.typ', '.git' },
	settings = {
		exportPdf = "onType",
		preview = { browsing = { args = {
			"--data-plane-host=127.0.0.1:0",
			"--invert-colors=auto",
			"--open",
			"--input",
			"info=nl.yml",
		} } },
	}
}
