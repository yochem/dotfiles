local function map(mode, lhs, rhs, opts)
	local options = { silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

local function cmd(command)
	return function()
		vim.cmd(command)
	end
end

map("n", '<Leader>O', '[<Space>', { remap = true, desc = "empty line above" })
map("n", '<Leader>o', ']<Space>', { remap = true, desc = "empty line below" })

map("v", "<", "<gv", { desc = "keep visual selection when indenting" })
map("v", ">", ">gv", { desc = "keep visual selection when indenting" })

-- resize windows
map("n", "<S-Up>", cmd("resize +2"))
map("n", "<S-Down>", cmd("resize -2"))
map("n", "<S-Left>", cmd("vertical resize +2"))
map("n", "<S-Right>", cmd("vertical resize -2"))

-- go through visual lines with j and k but don't mess with 10k etc.
map("n", "j", [[v:count ? 'j' : 'gj']], { expr = true })
map("n", "k", [[v:count ? 'k' : 'gk']], { expr = true })

-- use comma to switch windows
map("n", ",", "<c-w>")

-- Open new file in split
map("n", "<leader>e", cmd("15Lexplore"), { desc = "open file explorer on the left" })

-- don't care, just quit
map("n", "ZZ", vim.cmd.qall)

-- don't accidentally create macros when trying to quit
map("n", "Q", "q")

-- <leader>action means clipboard
for _, action in pairs({ "y", "d", "p" }) do
	map({ "n", "v" }, "<leader>" .. action, '"+' .. action)
	map({ "n", "v" }, "<leader>" .. action:upper(), '"+' .. action:upper())
end
map({ "n", "v" }, "<leader>Y", '"+y$')

map("v", "p", [["_dP"]])

map({ "n", "v" }, "c", '"_c', { desc = "do not add c action to register" })

-- don't put empty lines in register
map("n", "dd", [[getline(".") == "" ? '"_dd' : 'dd']], { expr = true })

-- populate jumplist with relative jumps
map("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . "k"]], { expr = true })
map("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . "j"]], { expr = true })


-- move highlighted text and auto indent
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move visually selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move visually selected lines up" })

map("n", "<Esc>", cmd("nohlsearch"))

-- don't move so aggressive
map("n", "<PageUp>", "10k")
map("n", "<PageDown>", "10j")

-- close window
map("n", "q", function()
	local success = pcall(vim.cmd.close)
	if not success then
		pcall(vim.cmd.quit)
	end
end)

map("n", "<leader>ff", function() require("telescope.builtin").find_files() end)
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end)
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end)
map("n", "<leader>fF", function() require("telescope.builtin").lsp_document_symbols() end)
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end)
map("n", "<leader>fq", function() require("telescope.builtin").quickfix() end)
map("n", "<leader>fd", function()
	require("telescope.builtin").find_files({ cwd = vim.fn.stdpath('config') })
end)

map("n", "zO", function() require("ufo").openAllFolds() end)
map("n", "zC", function() require("ufo").closeAllFolds() end)

-- toggle folds easily
-- map("n", "h", [[getcurpos()[2] == 1 ? "zc" : "h"]], { expr = true })

map("n", "<leader>D", vim.diagnostic.setqflist)
-- map("n", "<leader>D", vim.lsp.buf.declaration)
map("n", "<leader>gd", vim.lsp.buf.definition)
map("n", "<leader>r", vim.lsp.buf.references)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>f", vim.lsp.buf.format)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>h", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- map("n", "zg", function ()
-- 	vim.opt.spellfile = vim.fn.stdpath('data') .. '/spell/' .. vim.o.spelllang
-- 	vim.cmd("exe norm! zg")
-- end)

map("n", "!", function()
	local negates = {
		["true"] = "false",
		["false"] = "true",
		["True"] = "False",
		["False"] = "True",
	}

	-- get the entire word under cursor by moving to front and end
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line = cursor[1] - 1
	vim.cmd('exe "norm! wb"')
	local begin_word = vim.api.nvim_win_get_cursor(0)[2]
	vim.cmd('exe "norm! e"')
	local end_word = vim.api.nvim_win_get_cursor(0)[2] + 1

	local word = vim.api.nvim_buf_get_text(0, line, begin_word, line, end_word, {})[1]

	if negates[word] ~= nil then
		vim.api.nvim_buf_set_text(0, line, begin_word, line, end_word, { negates[word] })
	end

	-- restore cursor position
	vim.api.nvim_win_set_cursor(0, cursor)
end)

return {
	map = map,
	cmd = cmd,
}
