local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'joshdick/onedark.vim'
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-fugitive'
    use 'b3nj5m1n/kommentary'
    use 'junegunn/fzf.vim'
    use 'ojroques/nvim-hardline'
    use 'kevinhwang91/nvim-hlslens'
    use {'FooSoft/vim-argwrap', cmd = 'ArgWrap'}
    use 'wellle/targets.vim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'seblj/nvim-echo-diagnostics'

    -- filetypes
    use 'yochem/prolog.vim'
    use 'blankname/vim-fish'
    use {'vim-python/python-syntax', ft = {'python'}}
    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}}
    use {'chrisbra/csv.vim', ft = {'csv'}}
end)

require('kommentary.config').configure_language("lua", {
    prefer_single_line_comments = true
})

require('hlslens').setup({calm_down = true})

require('hardline').setup({
    theme = 'one',
    sections = {
        {class = 'mode', item = require('hardline.parts.mode').get_item},
        {
            class = 'high',
            item = require('hardline.parts.git').get_item,
            hide = 80
        }, '%<',
        {class = 'low', item = require('hardline.parts.filename').get_item},
        {class = 'med', item = '%='},
        {
            class = 'low',
            item = require('hardline.parts.wordcount').get_item,
            hide = 80
        }, {class = 'error', item = require('hardline.parts.lsp').get_error},
        {class = 'warning', item = require('hardline.parts.lsp').get_warning},
        {
            class = 'warning',
            item = require('hardline.parts.whitespace').get_item
        },
        {
            class = 'high',
            item = require('hardline.parts.filetype').get_item,
            hide = 80
        }, {
            class = 'mode',
            item = function()
                return string.format('%d:%d', vim.fn.line('.'), vim.fn.col('.'))
            end
        }
    }
})
