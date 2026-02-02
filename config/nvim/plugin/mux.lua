if true then return end
--[[
TODO:

- sessions!!
	- attach/detach
	- session selector (s.fish)
	- session names
- better window selector
- propagate the fish title to the statusline
- mark panes?
]]

local actions = {
	['1'] = 'norm! 1gt',
	['2'] = 'norm! 2gt',
	['3'] = 'norm! 3gt',
	['4'] = 'norm! 4gt',
	['5'] = 'norm! 5gt',
	['6'] = 'norm! 6gt',
	['7'] = 'norm! 7gt',
	['8'] = 'norm! 8gt',
	['9'] = 'norm! 9gt',
	['c'] = '$tabnew +terminal',
	['p'] = 'tabprevious',
	['n'] = 'tabnext',
	['w'] = 'tabs',
	['|'] = 'vertical terminal',
	['-'] = 'horizontal terminal',
	['x'] = 'close',
	['X'] = 'tabclose',
	['<Left>'] = 'tabmove -1',
	['<Right>'] = 'tabmove +1',
	['`'] = 'wincmd g\t',
	-- e = '', -- TODO: send ` character
}

local function tab_label(n, current, last)
	local buflist = vim.fn.tabpagebuflist(n)
	local winnr = vim.fn.tabpagewinnr(n)
	local buf = buflist[winnr]
	local name = vim.fn.fnamemodify(vim.fn.bufname(buf), ":t")
	if vim.bo[buf].modified then
		name = '● ' .. name
	end
	if name == "" then
		name = "unnamed"
	end
	local bold_start = current and '%#StlBold#' or ''
	local bold_end = current and '%#Statusline#' or ''
	local marker = ''
	if current then
		marker = '*'
	elseif last then
		marker = '-'
	end
	return string.format('%s%s%d: %s%s', bold_start, marker, n, name, bold_end)
end

local function tmux_tabs()
	local total = #vim.api.nvim_list_tabpages()
	local current = vim.api.nvim_tabpage_get_number(0)
	local last = vim.fn.tabpagenr('#')
	local tabs = {}
	for n = 1, total do
		table.insert(tabs, tab_label(n, n == current, n == last))
	end
	return ' ' .. table.concat(tabs, ' │ ')
end

function _G.tmux_statusline()
	local left = tmux_tabs()
	local right = vim.fn.strftime("%H:%M")
	return left .. "%=" .. right
end

local function setup()
	vim.keymap.set({ 'n', 't' }, '`', function()
		local char = vim.fn.keytrans(vim.fn.getchar(-1, { number = false }))
		local action = actions[char]
		if type(action) == 'string' then
			vim.cmd(action)
		elseif type(action) == 'function' then
			action()
		else
			print('no action for key: ' .. vim.fn.keytrans(char))
		end
	end)

	vim.api.nvim_set_hl(0, "StlBold", { bold = true })
	vim.o.laststatus = 3
	vim.o.showtabline = 0
	vim.o.statusline = "%{%v:lua.tmux_statusline()%}"
end

setup()
