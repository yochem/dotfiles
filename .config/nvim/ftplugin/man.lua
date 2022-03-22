local opts = {silent = true, noremap = true}

-- jump sections
vim.keymap.set('n', 'N', '/^[A-Z]<CR>:noh<CR>', opts)
vim.keymap.set('n', 'P', '?^[A-Z]<CR>:noh<CR>', opts)

-- list sections
vim.keymap.set('n', 'S', [[<CMD>g/^\w<CR>]], opts)

if (vim.env.TMUX ~= nil) then
    local fn = vim.fn.expand('%:t')
    fn = fn ~= '' and fn or 'nvim'
    os.execute("tmux rename-window '" .. fn .. "'")
end
