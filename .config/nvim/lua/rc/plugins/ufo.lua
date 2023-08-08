return {
	'kevinhwang91/nvim-ufo',
	config = {
		provider_selector = function(bufnr, filetype, buftype)
			return {'treesitter', 'indent'}
		end
	},
	dependencies = {
		'kevinhwang91/promise-async'
	},
	event = "BufReadPost",
}
