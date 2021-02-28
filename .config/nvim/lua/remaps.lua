local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- toggle list wrapping
map('n', '<leader>a', ':ArgWrap<CR>')

-- replace more characters at once in visual mode
map('v', 'r', '"_dP')

-- when jumping to definition place it in the middle of the screen
map('n', 'n', 'nzz')

-- delete trailing whitespace
map('n', 'W', [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>:noh<CR>]])

-- use arows to quickly scroll
map('n', '<UP>', '<C-u>')
map('n', '<DOWN>', '<C-d>')

-- go through visual lines with j and k but don't mess with 10k etc.
-- source: http://stackoverflow.com/a/21000307/2580955
map('n', 'j', [[v:count ? 'j' : 'gj']], {expr = true})
map('n', 'k', [[v:count ? 'k' : 'gk']], {expr = true})

-- hate using ctrl and using ctrl-w a lot
map('n', '<space>', '<C-w>')

-- Open new file in split
map('n', '<leader>t', ':Vexplore<CR>')
map('n', 'ZZ', ':qall<CR>')
map('n', '<leader>c', 'gcc')
map('n', 'S', '<nop>')
map('n', 'Y', 'y$')

-- don't accidently create macros
map('n', 'Q', 'q')
map('n', 'q', '<nop>')

-- add empty line below or above in normal mode
map('n', 'oo', 'm`o<Esc>``')
map('n', 'OO', 'm`O<Esc>``')

-- some lsp remaps
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- format whole file and keep cursor at same position
map('n', '<leader>f', "magggqG'a")
