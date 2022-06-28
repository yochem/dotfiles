local id = vim.api.nvim_create_augroup('rc', {})
local autocmd = function (event, opts)
    opts = vim.tbl_extend('keep', opts, {group = id})
    vim.api.nvim_create_autocmd(event, opts)
end

autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({timeout = 200, higroup = 'Visual'})
    end
})

-- open file with cursor on last position
autocmd('BufReadPost', {
    callback = function ()
        local mark = vim.fn.line([['"]])
        if 0 < mark and mark <= vim.fn.line("$") then
            vim.api.nvim_command([[normal! g'"]])
        end
    end
})

-- use template if available
autocmd('BufNewFile', {
    pattern = {'*.c', '*.tex', '*.go'},
    command = '0r ' .. vim.fn.stdpath('config') .. '/templates/<afile>:e',
    once = true
})

-- highligt non-ascii blue
vim.api.nvim_set_hl(0, 'nonascii', {bg = 'Blue'})
autocmd({'BufEnter', 'InsertLeave'}, {
    callback = function ()
        vim.cmd([[syntax match nonascii "[^\x00-\x7F]"]])
    end
})

-- highlight trailing whitespace intrusive red
vim.api.nvim_set_hl(0, 'ExtraWhitespace', {bg = 'red'})
autocmd('InsertEnter', {command = [[match ExtraWhitespace /\s\+\%#\@<!$/]]})
autocmd('InsertLeave', {command = [[match ExtraWhitespace /\s\+$/]]})

-- :help for lua files in nvim config dir
local cfgdir = vim.fn.stdpath('config')
autocmd('BufReadPost', {
    pattern = cfgdir .. '/*',
    callback = function ()
        vim.opt_local.keywordprg = ':help'
        vim.opt_local.path:append(cfgdir .. '/lua/')
    end
})

-- compile packer after changing file
autocmd('BufWritePost', {
    pattern = cfgdir .. '/lua/*',
    command = 'source <afile>'
})

-- rename tmux window to current filename
autocmd({'BufEnter', 'BufWritePost'}, {
    callback = function ()
        if (vim.env.TMUX ~= nil) then
            local fn = vim.fn.expand('%:t')
            fn = fn ~= '' and fn or 'nvim'
            os.execute("tmux rename-window '" .. fn .. "'")
        end
    end
})

-- go to the github repo of plugins
-- if vim.fn.expand('%:t') == 'plugins.lua' then
autocmd('BufEnter', {
    pattern = 'plugins.lua',
    callback = function ()
        vim.keymap.set('n', 'gh', function()
            -- strip ' and , from WORD under cursor
            local repo = vim.fn.substitute(vim.fn.expand('<cWORD>'), "[',]", '', 'g')
            os.execute('open https://github.com/' .. repo)
        end)
    end
})

-- autocmd({'VimEnter'}, {
--     callback = function ()
--         local ft = vim.opt.filetype:get()
--         vim.schedule(function ()
--             vim.cmd('TSInstall ' .. ft)
--         end)
--     end,
--     group = id
-- })

vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd('execute "new "')
    vim.opt_local.buftype = 'nofile'
    vim.opt_local.bufhidden = 'hide'
    vim.opt_local.swapfile = false
    vim.cmd('file scratch')
    vim.cmd('startinsert')
end, {})

vim.api.nvim_set_hl(0, 'htmlBold', {bold = true})
