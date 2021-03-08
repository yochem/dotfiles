local function opt(scope, key, value)
    local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

-- other settings
opt('o', 'termguicolors', true)
opt('o', 'timeoutlen', 250)
opt('o', 'hidden', true)
opt('o', 'wildignore', '*.swp,*.bak,*.pyc,*.out,*.aux,*.bbl,*.blg')
opt('o', 'mouse', 'a')
opt('o', 'updatetime', 100)
opt('o', 'clipboard', 'unnamed')
opt('o', 'autowrite', true)
opt('o', 'shellcmdflag', '-lc')
opt('o', 'completeopt', 'menuone,noinsert')

-- visible settings
opt('o', 'shortmess', 'WIFsc')
opt('w', 'spell', false)
opt('o', 'showmode', false)
opt('w', 'fillchars', 'eob: ')

-- window settings
opt('o', 'splitright', true)
opt('o', 'splitbelow', true)
opt('w', 'number', true)
opt('w', 'relativenumber', true)

-- search settings
opt('o', 'gdefault', true)
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'wrapscan', true)

-- scroll behaviour
opt('w', 'wrap', false)
opt('w', 'foldenable', false)
opt('w', 'colorcolumn', '83')
opt('o', 'scrolloff', 3)
opt('o', 'sidescrolloff', 3)

-- tabs / spaces settings
opt('b', 'tabstop', 8)
opt('b', 'softtabstop', 4)
opt('b', 'expandtab', true)
opt('b', 'shiftwidth', 4)
opt('o', 'shiftround', true)

-- show the LSP warningsigns in the number column
opt('w', 'signcolumn', 'number')

-- global variables
vim.g.mapleader = ","
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

if vim.fn.has('mac') == 1 then
    vim.g.python3_host_prog = '/usr/local/bin/python3'
else
    vim.g.python3_host_prog = '/usr/bin/python3'
end

-- lightline
vim.g.lightline = {
    active = {
        left = {
            {'mode', 'paste'},
            {'readonly', 'absolutepath', 'gitbranch', 'modified'}
        },
        right = {{'lineinfo'}, {'percent'}, {'filetype'}}
    },
    colorscheme = 'onedark',
    component_function = {gitbranch = 'FugitiveHead'}
}
