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
            require('kommentary.config').configure_language('default', {
                prefer_single_line_comments = true,
                use_consistent_indentation = true,
            })
        end
    }

    use 'junegunn/fzf.vim'

    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            local function lsp()
                return vim.lsp.buf_get_clients()[1].name
            end
            require('lualine').setup({
                options = {
                    icons_enabled = false,
                    component_separators = { left = '|', right = '|'},
                    section_separators = { left = '', right = ''},
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff'},
                    lualine_c = {{'filename', path = 1}},
                    lualine_x = {'encoding', 'filetype'},
                    lualine_y = {lsp, 'diagnostics'},
                    lualine_z = {'location'}
                },
            })
        end
    }

    use {
        'kevinhwang91/nvim-hlslens',
        config = function() require('hlslens').setup({calm_down = true}) end
    }

    use {'FooSoft/vim-argwrap', cmd = 'ArgWrap'}

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
                    fg0 = '#ffffff',
                    fg_light = '#ffffff',
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
        'lukas-reineke/virt-column.nvim',
        config = function() require('virt-column').setup() end
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


    use 'nvim-treesitter/nvim-treesitter'

    -- filetypes
    use 'yochem/prolog.vim'

    use 'blankname/vim-fish'

    use {'vim-python/python-syntax', ft = {'python'}}

    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}}

    use {'chrisbra/csv.vim', ft = {'csv'}}
end)
