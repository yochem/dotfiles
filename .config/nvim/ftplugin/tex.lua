vim.api.nvim_create_autocmd('VimLeave', {
    callback = function ()
        -- os.execute('rm ')
    end,
    group = 'rc'
})
