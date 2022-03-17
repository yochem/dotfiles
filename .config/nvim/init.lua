vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
require('rc.plugins')
require('rc.options')
require('rc.remaps')
require('rc.autocommands')
require('rc.lsp')


vim.cmd[[
if exists('g:started_by_firenvim')
  echo "hi"
  set laststatus=0
else
  set laststatus=2
endif
]]
if vim.g.started_by_firenvim == true then
    vim.cmd[[echoerr "hallo"]]
    vim.opt.laststatus = 0
end
vim.opt.guifont = 'Menlo'
