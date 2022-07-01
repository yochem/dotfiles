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
-- map('n', '<leader>a', cmd'ArgWrap')
map('n', '<leader>a', ':ArgWrap<CR>')

-- substitute word with content of default register
local substitute = require('substitute')
map('n', '<leader>s', substitute.operator)
map('n', '<leader>ss', substitute.line)
map('n', '<leader>S', substitute.eol)
map('x', '<leader>s', substitute.visual)

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

-- delete trailing whitespace
map('n', 'W',
	[[m`:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>:noh<CR>``]])

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
map('n', 'ZZ', cmd'qall')

-- don't accidently create macros when trying to quit
map('n', 'Q', 'q')
map('n', 'q', '')

-- some lsp remaps
map('n', '<leader>D', vim.lsp.buf.declaration)
map('n', '<leader>gd', vim.lsp.buf.definition)
map('n', '<leader>r', vim.lsp.buf.references)
map('n', '<leader>rn', vim.lsp.buf.rename)
map('n', '<leader>f', vim.lsp.buf.formatting)
map('n', '<leader>d', vim.diagnostic.open_float)
map('n', '<leader>h', vim.lsp.buf.hover)
map('n', '<leader>[', vim.diagnostic.goto_prev)
map('n', '<leader>]', vim.diagnostic.goto_next)
map('n', '<leader>c', vim.lsp.buf.code_action)

map('n', '<leader>ff', require("telescope.builtin").find_files)
map('n', '<leader>fg', require("telescope.builtin").live_grep)
map('n', '<leader>fb', require("telescope.builtin").buffers)

-- format whole file and keep cursor at same position
map('n', '<leader>F', "magggqG'a")

-- use tab to cycle through lsp completions
map('i', '<Tab>', function()
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, {expr = true})
map('i', '<S-Tab>', function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, {expr = true})

-- Use tab to go to next buffer
map('n', '<Tab>', cmd'bnext')

-- Easier use of the system clipboard
map({'n', 'v'}, '<leader>y', '"+y')
map({'n', 'v'}, '<leader>Y', '"+y$')

map('n', '<leader>p', '"+p')
map('n', '<leader>P', '"+P')

-- populate jumplist with relative jumps
map('n', 'k', "(v:count > 5 ? \"m'\" . v:count : '') . 'k'", {expr = true})
map('n', 'j', "(v:count > 5 ? \"m'\" . v:count : '') . 'j'", {expr = true})

-- gx does not work on macOS, temporary fix from vim #4738
map('n', 'gx',
	cmd"call netrw#BrowseX(expand((exists('g:netrw_gx')? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())")

-- use ! to negate a boolean under cursor
map('n', '!', function()
	local negates = {
		['true'] = 'false',
		['false'] = 'true',
		['True'] = 'False',
		['False'] = 'True',
	}
	local word = vim.fn.expand('<cword>')
	if negates[word] ~= nil then
		-- results in: exe "norm! ciwFalse"
		vim.cmd('exe "norm! ciw' .. negates[word] .. '"')
	end
end)