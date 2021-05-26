vim.cmd('packadd packer.nvim')

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'joshdick/onedark.vim'
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-fugitive'
    use 'b3nj5m1n/kommentary'
    use 'ojroques/nvim-hardline'
    use {'FooSoft/vim-argwrap', cmd = 'ArgWrap'}
    use 'wellle/targets.vim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'kevinhwang91/nvim-hlslens'

    -- filetypes
    use 'yochem/prolog.vim'
    use 'blankname/vim-fish'
    use 'vim-python/python-syntax'
    use 'Vimjas/vim-python-pep8-indent'
end)

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
        }, {class = 'mode', item = require('hardline.parts.line').get_item}
    }
})
