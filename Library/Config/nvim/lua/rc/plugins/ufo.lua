return {
	'kevinhwang91/nvim-ufo',
	init = function ()
		vim.keymap.set('n', 'zR', function ()
			require('ufo').openAllFolds()
		end)
		vim.keymap.set('n', 'zR', function ()
			require('ufo').closeAllFolds()
		end)
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
