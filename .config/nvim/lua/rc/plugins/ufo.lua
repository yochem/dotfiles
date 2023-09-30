
return {
	'kevinhwang91/nvim-ufo',
	init = function ()
		vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
		vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
	end,
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
