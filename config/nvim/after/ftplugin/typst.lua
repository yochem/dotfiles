vim.opt.formatoptions:append('t')
vim.cmd([[set shiftwidth=2 expandtab softtabstop=2]])

vim.keymap.set('n', '<leader>p', vim.cmd.TypstPreview, { buffer = true })
