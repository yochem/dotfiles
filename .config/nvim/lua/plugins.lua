vim.cmd('packadd packer.nvim')

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'joshdick/onedark.vim'
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'
    use 'hoob3rt/lualine.nvim'
    use {'FooSoft/vim-argwrap', cmd = 'ArgWrap'}
    use 'wellle/targets.vim'
    use 'romainl/vim-cool'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'RRethy/vim-illuminate'

    -- filetypes
    use 'yochem/prolog.vim'
    use 'blankname/vim-fish'
    use 'vim-python/python-syntax'
    use 'Vimjas/vim-python-pep8-indent'
end)
