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

-- populate jumplist with relative jumps
map("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . "k"]], { expr = true })
map("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . "j"]], { expr = true })

-- move highlighted text and auto indent
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move visually selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move visually selected lines up" })

map("n", "<Esc>", vim.cmd.nohlsearch)

-- don't move so aggressive
map("n", "<PageUp>", "10k")
map("n", "<PageDown>", "10j")

-- don't care, just quit
map("n", "ZZ", vim.cmd.qall)

-- close window
map("n", "q", function()
	local success = pcall(vim.cmd.close)
	if not success then
		pcall(vim.cmd.quit)
	end
end)

-- use Q for macros
map("n", "Q", "q")

-- negate boolean values
map("n", "!", "<Plug>(Negate)")
