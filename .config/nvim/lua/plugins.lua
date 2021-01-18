vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    use 'joshdick/onedark.vim'
    use 'sheerun/vim-polyglot'
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'
    use 'yochem/prolog.vim'
    use 'itchyny/lightline.vim'
    use 'FooSoft/vim-argwrap'
    use 'wellle/targets.vim'
    use 'romainl/vim-cool'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
end)
