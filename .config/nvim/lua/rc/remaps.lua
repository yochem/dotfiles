local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- add empty line below or above in normal mode
map('n', 'oo', 'm`o<Esc>``')
map('n', 'OO', 'm`O<Esc>``')

-- toggle list wrapping
map('n', '<leader>a', ':ArgWrap<CR>')

-- when text is visual selected, replace it with system clipboard
map('v', 'r', '"_dP')

-- when jumping through search always center
map('n', 'n', 'nzz')

-- delete trailing whitespace
map('n', 'W',
    [[m`:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>:noh<CR>``]])

-- go through visual lines with j and k but don't mess with 10k etc.
-- source: http://stackoverflow.com/a/21000307/2580955
if vim.api.nvim_win_get_option(0, 'wrap') == true then
    map('n', 'j', [[v:count ? 'j' : 'gj']], {expr = true})
    map('n', 'k', [[v:count ? 'k' : 'gk']], {expr = true})
end

-- I should use space for something better now I use tmux
map('n', '<space>', '<C-w>')

-- Open new file in split
map('n', '<leader>t', ':Vexplore<CR>')

-- don't care, just quit
map('n', 'ZZ', ':qall<CR>')

-- quickly comment line
map('n', '<leader>c', '<Plug>kommentary_line_default', {noremap = false})

-- often pressed accidently, cc works fine too
map('n', 'S', '<nop>')
map('n', 'Y', 'y$')

-- don't accidently create macros when trying to quit
map('n', 'Q', 'q')
map('n', 'q', '<nop>')

-- some lsp remaps
map('n', '<leader>D', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>r', '<Cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
map('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>')
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>')
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>')

-- format whole file and keep cursor at same position
map('n', '<leader>F', "magggqG'a")

-- use tab to cycle through lsp completions
map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], {expr = true})
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], {expr = true})

-- Use tab to go to next buffer
-- map('n', '<Tab>', '<Cmd>bn<CR>')

-- Easier use of the system clipboard
map('n', '<leader>y', '"+y')
map('n', '<leader>Y', '"+y$')

map('v', '<leader>y', '"+y')
map('v', '<leader>Y', '"+y$')

map('n', '<leader>p', '"+p')
map('n', '<leader>P', '"+P')

-- populate jumplist with relative jumps
map('n', 'k', "(v:count > 5 ? \"m'\" . v:count : '') . 'k'", {expr = true})
map('n', 'j', "(v:count > 5 ? \"m'\" . v:count : '') . 'j'", {expr = true})

-- gx does not work on macOS, temporary fix from vim #4738
map('n', 'gx',
    ":call netrw#BrowseX(expand((exists('g:netrw_gx')? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())<cr>")

function _G.negateBoolUnderCursor()
    local word = vim.fn.expand('<cword>')
    if word == 'true' then
        vim.cmd[[exe "norm! ciw" . 'false']]
        return 'false'
    elseif word == 'false' then
        vim.cmd[[exe "norm! ciw" . 'true']]
    elseif word == 'True' then
        vim.cmd[[exe "norm! ciw" . 'False']]
    elseif word == 'False' then
        vim.cmd[[exe "norm! ciw" . 'True']]
    end
end

map('n', '!', ':lua negateBoolUnderCursor()<CR>')

if vim.fn.expand('%:t') == 'plugins.lua' then
    map('n', 'gh', [[:silent exe "!open https://github.com/" . substitute(expand("<cWORD>"), "'", "", 'g')<CR>]])
end
