return {
	"FooSoft/vim-argwrap",
	init = function ()
		vim.keymap.set('n', '<leader>a', vim.cmd.ArgWrap, {silent=true})
	end,
	cmd = 'ArgWrap'
}
