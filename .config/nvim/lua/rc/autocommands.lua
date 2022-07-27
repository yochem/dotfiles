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
		local mark = vim.api.nvim_buf_get_mark(0, [["]])
		if 0 < mark[1] and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
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
autocmd({'BufEnter', 'InsertLeave'}, {
	callback = function ()
		vim.api.nvim_set_hl(0, 'nonascii', {bg = 'Blue'})
		vim.cmd([[syntax match nonascii "[^\x00-\x7F]"]])
	end
})

-- highlight trailing whitespace intrusive red
autocmd('InsertEnter', {
	callback = function ()
		vim.cmd([[match TrailingWhitespace /\s\+\%#\@<!$/]])
		vim.api.nvim_set_hl(0, 'TrailingWhitespace', {bg = 'red'})
	end
})
autocmd({'InsertLeave', 'BufEnter'}, {
	callback = function ()
		vim.cmd([[match TrailingWhitespace /\s\+$/]])
		vim.api.nvim_set_hl(0, 'TrailingWhitespace', {bg = 'red'})
	end
})

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

vim.api.nvim_create_user_command('Scratch', function()
	vim.cmd('execute "new "')
	vim.opt_local.buftype = 'nofile'
	vim.opt_local.bufhidden = 'hide'
	vim.opt_local.swapfile = false
	vim.cmd('file scratch')
	vim.cmd('startinsert')
end, {})

vim.api.nvim_set_hl(0, 'htmlBold', {bold = true})
