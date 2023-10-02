return {
	"narutoxy/dim.lua",
	dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
	opts = {},
	cond = function()
		return vim.api.nvim_buf_line_count(0) < 10000
	end,
	event = "BufReadPost",
}
