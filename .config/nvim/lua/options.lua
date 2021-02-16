vim.cmd('syntax enable')
vim.cmd("let mapleader = ','")
vim.cmd('filetype plugin on')
vim.cmd('filetype on')

local function opt(scope, key, value)
    local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

-- other settings
opt('o', 'termguicolors', true)
opt('o', 'timeoutlen', 250)
opt('o', 'startofline', false)
opt('o', 'encoding', 'utf-8')
opt('o', 'hidden', true)
opt('o', 'wildignore', '*.swp,*.bak,*.pyc,*.pdf,*.out,*.aux,*.bbl,*.blg')
opt('o', 'mouse', 'a')
opt('o', 'compatible', false)
opt('o', 'ttyfast', true)
opt('o', 'updatetime', 100)
opt('o', 'clipboard', 'unnamed')
opt('o', 'autowrite', true)
opt('o', 'shellcmdflag', '-lc')
opt('o', 'completeopt', 'menuone,noinsert')

-- visible settings
opt('o', 'shortmess', 'WIFsc')
opt('o', 'title', false)
opt('o', 'errorbells', false)
opt('w', 'spell', false)
opt('o', 'laststatus', 2)
opt('o', 'showmode', false)
opt('w', 'fillchars', 'eob: ')

-- window settings
opt('o', 'splitright', true)
opt('o', 'splitbelow', true)
opt('w', 'number', true)
opt('w', 'relativenumber', true)

-- search settings
opt('o', 'gdefault', true)
opt('o', 'hlsearch', true)
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'incsearch', true)
opt('o', 'wrapscan', true)

-- scroll behaviour
opt('o', 'backspace', 'indent,eol,start')
opt('w', 'wrap', false)
opt('w', 'foldenable', false)
opt('w', 'colorcolumn', '83')
opt('o', 'scrolloff', 3)
opt('o', 'sidescrolloff', 3)

-- indentation settings
opt('b', 'autoindent', true)
opt('o', 'smarttab', true)

-- tabs / spaces settings
opt('b', 'tabstop', 8)
opt('b', 'softtabstop', 4)
opt('b', 'expandtab', true)
opt('b', 'shiftwidth', 4)
opt('o', 'shiftround', true)

-- global variables
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.MRU_File = vim.fn.stdpath('data') .. '/mru.txt'

if vim.fn.has('mac') == 1 then
    vim.g.python3_host_prog = '/usr/local/bin/python3'
    vim.g.clipboard = {
        cache_enabled = 0,
        copy = {
            ["*"] = "pbcopy",
            ["+"] = "pbcopy"
        },
        name = "pbcopy",
        paste = {
            ["*"] = "pbpaste",
            ["+"] = "pbpaste"
        }
    }
end

-- lightline
vim.g.lightline = {
    active = {
        left = {
            {"mode", "paste"},
            {"readonly", "absolutepath", "gitbranch", "modified"}
        },
        right = {
            {"lineinfo"},
            {"percent"},
            {"filetype"}
        }
    },
    colorscheme = "onedark",
    component_function = {
        gitbranch = "FugitiveHead"
    }
}
