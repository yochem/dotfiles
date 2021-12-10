local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'editorconfig/editorconfig-vim'

    use 'tpope/vim-fugitive'

    use {
        'b3nj5m1n/kommentary',
        config = function()
            require('kommentary.config').configure_language("lua", {
                prefer_single_line_comments = true
            })
        end
    }

    use 'junegunn/fzf.vim'

    use {
        'ojroques/nvim-hardline',
        config = function()
            require('hardline').setup({
                theme = 'one',
                sections = {
                    {
                        class = 'mode',
                        item = require('hardline.parts.mode').get_item
                    },
                    {
                        class = 'high',
                        item = require('hardline.parts.git').get_item,
                        hide = 80
                    }, '%<',
                    {
                        class = 'low',
                        item = require('hardline.parts.filename').get_item
                    },
                    {
                        class = 'med',
                        item = '%='
                    },
                    {
                        class = 'low',
                        item = require('hardline.parts.wordcount').get_item,
                        hide = 80
                    },
                    {
                        class = 'error',
                        item = require('hardline.parts.lsp').get_error
                    },
                    {
                        class = 'warning',
                        item = require('hardline.parts.lsp').get_warning
                    },
                    {
                        class = 'warning',
                        item = require('hardline.parts.whitespace').get_item
                    },
                    {
                        class = 'high',
                        item = require('hardline.parts.filetype').get_item,
                        hide = 80
                    },
                    {
                        class = 'mode',
                        item = function()
                            return string.format('%d:%d', vim.fn.line('.'), vim.fn.col('.'))
                        end
                    }
                }
            })
        end
    }

    use {
        'kevinhwang91/nvim-hlslens',
        config = function()
            require('hlslens').setup({calm_down = true})
        end
    }

    use {
        'FooSoft/vim-argwrap',
        cmd = 'ArgWrap'
    }

    use 'wellle/targets.vim'

    use {
        'ful1e5/onedark.nvim',
        config = function()
            require("onedark").setup({
                transparent = true,
                transparent_sidebar = false,
                comment_style = "NONE",
                keyword_style = "NONE",
                function_style = "NONE",
                variable_style = "NONE",
                colors = {
                    fg = '#ffffff',
                    fg_light = '#ffffff',
                    fg_dark = '#ffffff'
                }
            })
        end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function ()
            require('indent_blankline').setup({
                filetype_exclude = {'help', 'man'},
                show_first_indent_level = false,
                show_trailing_blankline_indent = false
            })
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    -- LSP
    use 'neovim/nvim-lspconfig'

    use {'L3MON4D3/LuaSnip', config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        cmp.setup {
            snippet = {
                expand = function(args)
                require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = {
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
                },
                ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
                end,
                ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
                end,
            },
            sources = {{ name = 'nvim_lsp' }}
        }
        end,
        requires = {
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip'
        }
    }

    -- use 'seblj/nvim-echo-diagnostics'
    use {'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate'}

    -- filetypes
    use 'yochem/prolog.vim'

    use 'blankname/vim-fish'

    use {'vim-python/python-syntax', ft = {'python'}}

    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}}

    use {'chrisbra/csv.vim', ft = {'csv'}}
end)
