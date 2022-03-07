local autocmd = vim.api.nvim_create_autocmd

-- open file with cursor on last position
autocmd('BufReadPost', {
    callback = function ()
        local mark = vim.fn.line([['"]])
        if 0 < mark and mark <= vim.fn.line("$") then
            vim.api.nvim_command([[normal! g'"]])
        end
    end
})

-- right filetypes
local function set_filetype(ext, ft)
    autocmd({'BufRead', 'BufNewFile'}, {
        pattern = '*.' .. ext,
        command = 'setlocal filetype=' .. ft
    })
end
set_filetype('tex', 'tex')
set_filetype('tmpl', 'gohtmltmpl')

-- highligt non-ascii blue
vim.cmd [[highlight nonascii guibg=Blue ctermbg=9]]
vim.cmd [[au BufEnter,InsertLeave match nonascii "[^\x00-\x7F]"]]

-- highlight trailing whitespace intrusive red
autocmd('BufReadPost', {command = 'highlight ExtraWhitespace ctermbg=red guibg=red'})
autocmd('InsertEnter', {command = [[match ExtraWhitespace /\s\+\%#\@<!$/]]})
autocmd('InsertLeave', {command = [[match ExtraWhitespace /\s\+$/]]})

-- :help for lua files in nvim config dir
local cfgdir = vim.fn.stdpath('config')
autocmd('BufEnter', {
    pattern = cfgdir .. '/*',
    callback = function ()
        vim.opt_local.keywordprg = ':help'
        vim.opt_local.path:append(cfgdir .. '/lua/')
    end,
})

-- compile packer after changing file
autocmd('BufWritePost', {
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile'
})

-- rename tmux window to current filename
if (vim.env.TMUX ~= nil) then
    local fn = vim.fn.expand('%:t')
    fn = fn ~= '' and fn or 'nvim'
    os.execute("tmux rename-window '" .. fn .. "'")
end

vim.api.nvim_add_user_command('Scratch', function()
    vim.cmd('execute "new "')
    vim.opt_local.buftype = 'nofile'
    vim.opt_local.bufhidden = 'hide'
    vim.opt_local.swapfile = false
    vim.cmd('file scratch')
    vim.cmd('startinsert')
end, {})
