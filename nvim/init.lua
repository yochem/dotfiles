if vim.g.vscode or vim.fn.has('nvim-0.10') == 0 then
  return
end

local old = vim.opt.runtimepath:get()
vim.opt.runtimepath = vim.iter(old):filter(function(el)
  return vim.uv.fs_stat(vim.fs.normalize(el)) ~= nil
end):totable()

vim.cmd.colorscheme('mine')
vim.schedule(function()
  require('vim._core.ui2').enable({})
end)

vim.g.did_install_default_menus = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1

-------------
-- OPTIONS --
-------------
vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.o.laststatus = 0
vim.o.showmode = false
vim.o.ruler = false
vim.o.shortmess = 'WIFsclo'

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = 'screen'

vim.o.textwidth = 79
vim.o.wrap = false

vim.o.foldcolumn = '1'
vim.o.number = true
vim.o.numberwidth = 1
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:1'
vim.o.cursorline = true

vim.o.list = true
vim.o.pumheight = 10
vim.o.scrolloff = 3
vim.o.sidescrolloff = 1

vim.o.pumheight = 10
vim.o.completeopt = 'menu,menuone,noselect'

vim.o.title = true
vim.o.titlestring = '%{&modified?"● ":""}%{empty(expand("%"))?"nvim":expand("%:~:.")}'

vim.o.formatoptions = 'cqnj'
vim.opt.jumpoptions:append({ 'view', 'stack' })

vim.o.gdefault = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.smartcase = true

vim.o.expandtab = false
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.softtabstop = -1
vim.o.tabstop = 4

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
vim.o.foldtext = ''

vim.o.spell = true
vim.o.spellsuggest = '10'
vim.o.spelloptions = 'camel,noplainbuffer'

vim.o.autowrite = true
vim.o.hidden = false
vim.o.undofile = true
vim.o.exrc = true
vim.o.secure = true

vim.o.shellcmdflag = '-Nc'
vim.o.timeoutlen = 400
vim.o.updatetime = 100

vim.opt.path:append({ '**' })
vim.o.wildmenu = true
vim.opt.suffixes:append({ '.pyc', '.out', '.pdf' })

vim.o.conceallevel = 2

vim.opt.fillchars = {
  eob = ' ',
  fold = ' ',
  foldopen = '',
  foldsep = ' ',
  foldclose = '',
  foldinner = ' ',
}
vim.opt.listchars = {
  tab = '│ ',
  trail = '•',
  -- multispace = '••',
}

--------------
-- AUTOCMDS --
--------------
local augroup = vim.api.nvim_create_augroup('yochem', {})
function _G.on(event, callback, opts)
  opts = opts or {}
  if type(callback) == 'function' then
    opts.callback = callback
  else
    opts.command = callback
  end
  opts.group = opts.group or augroup
  vim.api.nvim_create_autocmd(event, opts)
end

on('FileType', function(ev)
  if vim.bo[ev.buf].buftype ~= '' then return end
  local ok = pcall(vim.treesitter.start, ev.buf)
  if ok then
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  else
    vim.print(('TS parser not installed for filetype %s'):format(ev.match))
  end
end)

on('TextYankPost', function()
  vim.hl.on_yank({ timeout = 200, higroup = 'Visual' })
end)

on('BufNewFile', function(ev)
  on('BufWritePre', function(ev2)
    vim.fn.mkdir(vim.fs.dirname(ev2.match), 'p')
  end, { buffer = ev.buf, once = true })
end)

on('WinNew', function()
  on({ 'BufReadPost', 'BufNewFile' }, function()
    if vim.fn.win_gettype() ~= '' then return end
    if vim.api.nvim_win_get_width(0) > 2 * 74 then
      vim.cmd.wincmd(vim.o.splitright and 'L' or 'H')
    end
  end, { once = true })
end, { desc = 'split vertical if theres room' })

vim.api.nvim_create_user_command('Pager', function()
  vim.api.nvim_open_term(0, {})
end, { desc = 'Highlights ANSI termcodes in curbuf' })

vim.api.nvim_create_user_command('Make', function()
  -- TODO: smaller size
  vim.cmd([[hor terminal ]] .. vim.o.makeprg)
  vim.cmd.startinsert()
  -- vim.api.nvim_win_set_height(0, math.floor(vim.api.nvim_win_get_height(0) / 2))
end, {})

------------
-- REMAPS --
------------
local function cmd(command) return function() vim.cmd(command) end end
local map = vim.keymap.set

map('n', 'OO', '[<Space>', { remap = true })
map('n', 'oo', ']<Space>', { remap = true })

-- move highlighted text and auto indent
map('x', 'J', ":m '>+1<CR>gv=gv")
map('x', 'K', ":m '<-2<CR>gv=gv")

map('x', 'P', 'p')
map('x', 'p', 'P')

-- keep selection while visually indenting
map('x', '<', '<gv')
map('x', '>', '>gv')

-- use comma to switch windows
map('n', ',', '<c-w>')

-- don't move so aggressive
map('n', '<PageUp>', '10k')
map('n', '<PageDown>', '10j')

-- populate jumplist with relative jumps, otherwise move by wrapped line
map('n', 'k', [[(v:count ? "m'" . v:count : "g") . "k"]], { expr = true })
map('n', 'j', [[(v:count ? "m'" . v:count : "g") . "j"]], { expr = true })

-- reselect pasted text like |gv| does for visually selected text
map('n', 'gp', '`[v`]')

map('n', '<Esc>', function()
  vim.cmd.nohlsearch()
  vim.snippet.stop()
end)

-- always jump exactly to mark
map('n', [[']], [[`]])

-- preserve cursor on joining lines
map('n', 'gJ', 'J"_x')

-- set mark before searching
map('n', '/', 'ms/')
map('n', '?', 'ms?')

-- only search in visual selection
map('x', '/', '<Esc>/\\%V')

-- don't care, just quit
map('n', 'ZZ', vim.cmd.qall)

-- close window
map('n', 'q', function()
  local success = pcall(vim.cmd.close)
  if not success then
    pcall(vim.cmd.quit)
  end
end)

map('n', '<leader>q', function()
  for _, w in ipairs(vim.fn.getwininfo()) do
    if w.quickfix == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end)

-- keep Q for macros
map('n', 'Q', 'q')

-- negate boolean values
map('n', '!', '<Plug>(Negate)')

-- ignore 'scrolloff' with H and L
map('n', 'H', function()
  vim._with({ o = { scrolloff = 0 } }, function()
    vim.cmd('norm! H')
  end)
end)

map('n', 'L', function()
  vim._with({ o = { scrolloff = 0 } }, function()
    vim.cmd('norm! L')
  end)
end)

-- sensible normal mode in terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>')

map('n', '<leader>r', '<CMD>update | Make<CR>')


-- Tree-sitter textobjects
local keymaps = {
  ['af'] = '@function.outer',
  ['if'] = '@function.inner',
  ['aC'] = '@class.outer',
  ['iC'] = '@class.inner',
  ['ab'] = '@block.outer',
  ['ib'] = '@block.inner',
  ['aa'] = '@parameter.outer',
  ['ia'] = '@parameter.inner',
  ['as'] = '@statement.outer',
  ['ic'] = '@comment.inner',
  ['ac'] = '@comment.outer',
}

for rhs, object in pairs(keymaps) do
  map({ 'x', 'o' }, rhs, function()
    local ts_select = require('nvim-treesitter-textobjects.select')
    ts_select.select_textobject(object, 'textobjects')
  end)
end

map('n', '[f', function()
  local ts_move = require('nvim-treesitter-textobjects.move')
  ts_move.goto_previous_start('@function.outer', 'textobjects')
end)
map('n', ']f', function()
  local ts_move = require('nvim-treesitter-textobjects.move')
  ts_move.goto_next_start('@function.outer', 'textobjects')
end)

map('n', ']h', '<Cmd>Gitsigns next_hunk<CR>')
map('n', '[h', '<Cmd>Gitsigns prev_hunk<CR>')

map("n", "<leader><leader>", "<Plug>(artio-files)")
map("n", "<leader>fg", "<Plug>(artio-grep)")
map("n", "<leader>ff", "<Plug>(artio-smart)")
map("n", "<leader>fh", "<Plug>(artio-helptags)")
map("n", "<leader>fb", "<Plug>(artio-buffers)")
map("n", "<leader>f/", "<Plug>(artio-buffergrep)")

local old_open = vim.ui.open
vim.ui.open = function(path, opts)
  opts = opts or {}
  if path:match('#%d+') then
    opts.cmd = { 'gh', 'browse' }
  end
  return old_open(path, opts)
end

require('plugins')
