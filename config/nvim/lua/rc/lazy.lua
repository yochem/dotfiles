local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath
	}):wait()
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	default = {
		lazy = true,
	},
	change_detection = {
		notify = false,
	},
	install = {
		colorscheme = { "mine" },
	}
})
