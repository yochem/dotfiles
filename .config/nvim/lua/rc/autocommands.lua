local autocmd = vim.api.nvim_create_autocmd

local id = vim.api.nvim_create_augroup('rc', {})

-- open file with cursor on last position
autocmd('BufReadPost', {
    callback = function ()
        local mark = vim.fn.line([['"]])
        if 0 < mark and mark <= vim.fn.line("$") then
            vim.api.nvim_command([[normal! g'"]])
        end
    end,
    group = id
})

-- use template if available
autocmd('BufNewFile', {
    pattern = {'*.c', '*.tex', '*.go'},
    command = '0r ' .. vim.fn.stdpath('config') .. '/templates/<afile>:e',
    once = true,
    group = id
})

-- highligt non-ascii blue
autocmd({'BufEnter', 'InsertLeave'}, {
    callback = function ()
        vim.cmd([[highlight nonascii guibg=Blue ctermbg=9]])
        vim.cmd([[syntax match nonascii "[^\x00-\x7F]"]])
    end,
    group = id
})

-- highlight trailing whitespace intrusive red
autocmd('BufReadPost', {
    command = 'highlight ExtraWhitespace ctermbg=red guibg=red',
    group = id
})

autocmd('InsertEnter', {
    command = [[match ExtraWhitespace /\s\+\%#\@<!$/]],
    group = id
})

autocmd('InsertLeave', {
    command = [[match ExtraWhitespace /\s\+$/]],
    group = id
})

-- :help for lua files in nvim config dir
local cfgdir = vim.fn.stdpath('config')
autocmd('BufReadPost', {
    pattern = cfgdir .. '/*',
    callback = function ()
        vim.opt_local.keywordprg = ':help'
        vim.opt_local.path:append(cfgdir .. '/lua/')
    end,
    group = id
})

-- compile packer after changing file
autocmd('BufWritePost', {
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
    group = id
})

-- rename tmux window to current filename
autocmd({'BufEnter', 'BufWritePost'}, {
    callback = function ()
        if (vim.env.TMUX ~= nil) then
            local fn = vim.fn.expand('%:t')
            fn = fn ~= '' and fn or 'nvim'
            os.execute("tmux rename-window '" .. fn .. "'")
        end
    end,
    group = id
})

vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd('execute "new "')
    vim.opt_local.buftype = 'nofile'
    vim.opt_local.bufhidden = 'hide'
    vim.opt_local.swapfile = false
    vim.cmd('file scratch')
    vim.cmd('startinsert')
end, {})
