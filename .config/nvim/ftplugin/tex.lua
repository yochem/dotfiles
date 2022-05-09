vim.api.nvim_create_autocmd('VimLeave', {
    callback = function ()
        local fn = vim.fn.expand('%:r')
        local exts = table.concat({
            'aux',
            'bbl',
            'blg',
            'fdb_latexmk',
            'fls',
            'log',
            'out',
            'toc',
        }, ',')
        vim.schedule(os.execute('rm ' .. fn .. '.{' .. exts .. '} >/dev/null 2>&1'))
    end,
    group = 'rc'
})
