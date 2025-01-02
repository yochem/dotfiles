local function cmd(command)
	return function()
		vim.cmd(command)
	end
end

local nmap = function (lhs, rhs, opts)
	vim.keymap.set("n", lhs, rhs, opts)
end

local vmap = function (lhs, rhs, opts)
	vim.keymap.set("v", lhs, rhs, opts)
end

nmap('<Leader>O', '[<Space>', { remap = true })
nmap('<Leader>o', ']<Space>', { remap = true })

-- move highlighted text and auto indent
vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")

-- keep selection while visually indenting
vmap("<", "<gv")
vmap(">", ">gv")

-- resize windows
nmap("<S-Up>", cmd("resize +2"))
nmap("<S-Down>", cmd("resize -2"))
nmap("<S-Left>", cmd("vertical resize +2"))
nmap("<S-Right>", cmd("vertical resize -2"))

-- use comma to switch windows
nmap(",", "<c-w>")

-- Open file explorer left
nmap("<leader>e", cmd("15Lexplore"))

-- don't move so aggressive
nmap("<PageUp>", "10k")
nmap("<PageDown>", "10j")

-- populate jumplist with relative jumps, otherwise move by wrapped line
nmap("k", [[(v:count ? "m'" . v:count : "g") . "k"]], { expr = true })
nmap("j", [[(v:count ? "m'" . v:count : "g") . "j"]], { expr = true })

nmap("<Esc>", vim.cmd.nohlsearch)

-- don't care, just quit
nmap("ZZ", vim.cmd.qall)

-- close window
nmap("q", function()
	local success = pcall(vim.cmd.close)
	if not success then
		pcall(vim.cmd.quit)
	end
end)

-- keep Q for macros
nmap("Q", "q")

-- negate boolean values
nmap("!", "<Plug>(Negate)")
