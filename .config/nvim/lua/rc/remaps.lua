local function map(mode, lhs, rhs, opts)
	local options = {silent = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.keymap.set(mode, lhs, rhs, options)
end

local function cmd(command)
	return function ()
		vim.cmd(command)
	end
end

-- add empty line below or above in normal mode
map('n', 'oo', 'm`o<Esc>``')
map('n', 'OO', 'm`O<Esc>``')

-- toggle list wrapping
map('n', '<leader>a', vim.cmd.ArgWrap)

-- when jumping through search always center
map('n', 'n', 'nzz')

-- stay in visual selection when indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- resize windows
map('n', '<S-Up>', cmd'resize +2')
map('n', '<S-Down>', cmd'resize -2')
map('n', '<S-Left>', cmd'vertical resize +2')
map('n', '<S-Right>', cmd'vertical resize -2')

-- go through visual lines with j and k but don't mess with 10k etc.
-- source: http://stackoverflow.com/a/21000307/2580955
if vim.opt.wrap:get() then
	map('n', 'j', [[v:count ? 'j' : 'gj']], {expr = true})
	map('n', 'k', [[v:count ? 'k' : 'gk']], {expr = true})
end

-- use comma to switch windows
map('n', ',', '<c-w>')

-- Open new file in split
map('n', '<leader>e', cmd'25Lexplore')

-- don't care, just quit
map('n', 'ZZ', vim.cmd.qall)

-- don't accidently create macros when trying to quit
map('n', 'Q', 'q')

-- some lsp remaps
map('n', '<leader>D', vim.lsp.buf.declaration)
map('n', '<leader>gd', vim.lsp.buf.definition)
map('n', '<leader>r', vim.lsp.buf.references)
map('n', '<leader>rn', vim.lsp.buf.rename)
map('n', '<leader>f', vim.lsp.buf.format)
map('n', '<leader>h', vim.lsp.buf.hover)
map('n', '<leader>[', vim.diagnostic.goto_prev)
map('n', '<leader>]', vim.diagnostic.goto_next)
map('n', '<leader>c', vim.lsp.buf.code_action)

map('n', '<leader>ff', require("telescope.builtin").find_files)
map('n', '<leader>fg', require("telescope.builtin").live_grep)
map('n', '<leader>fb', require("telescope.builtin").buffers)

map('n', '<leader>t', vim.cmd.TroubleToggle)

-- format whole file and keep cursor at same position
map('n', '<leader>F', "magggqG'a")

map(
	'i',
	'<Tab>',
	"luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
	{expr = true}
)
map('i', '<S-Tab>', function() require("luasnip").jump(-1) end)

-- Use tab to go to next buffer
map('n', '<Tab>', vim.cmd.bnext)

-- <leader>action means clipboard
for _, action in pairs({'y', 'd', 'p', 'y$', 'D', 'P'}) do
	map({'n', 'v'}, '<leader>' .. action, '"+' .. action)
end

map('v', 'p', [["_dP"]])

-- populate jumplist with relative jumps
map('n', 'k', [[(v:count > 5 ? "m'" . v:count : '') . 'k']], {expr = true})
map('n', 'j', [[(v:count > 5 ? "m'" . v:count : '') . 'j']], {expr = true})

-- move highlighted text and auto indent
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- close window
map('n', 'q', vim.cmd.close)


-- gx does not work on macOS, temporary fix from vim #4738
map('n', 'gx',
	cmd"call netrw#BrowseX(expand((exists('g:netrw_gx')? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())")


map('n', '!', function()
	local nvim_buf_get_text = vim.api.nvim_buf_get_text
	local nvim_buf_set_text = vim.api.nvim_buf_set_text
	local nvim_win_get_cursor = vim.api.nvim_win_get_cursor
	local nvim_win_set_cursor = vim.api.nvim_win_set_cursor

	local negates = {
		['true'] = 'false',
		['false'] = 'true',
		['True'] = 'False',
		['False'] = 'True',
	}

	-- get the entire word under cursor by moving to front and end
	local cursor = nvim_win_get_cursor(0)
	local line = cursor[1] - 1
	vim.cmd('exe "norm! wb"')
	local begin_word = nvim_win_get_cursor(0)[2]
	vim.cmd('exe "norm! e"')
	local end_word = nvim_win_get_cursor(0)[2] + 1

	local word = nvim_buf_get_text(0, line, begin_word, line, end_word, {})[1]

	if negates[word] ~= nil then
		nvim_buf_set_text(0, line, begin_word, line, end_word, {negates[word]})
	end

	-- restore cursor position
	nvim_win_set_cursor(0, cursor)
end)
