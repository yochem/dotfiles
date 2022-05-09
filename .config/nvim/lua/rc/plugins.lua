local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

require('packer').startup(function(use)
    use {'wbthomason/packer.nvim', opt = true}

    use 'gpanders/editorconfig.nvim'

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
                },
                overrides = function(c)
                    return {
                        MsgArea = {fg = c.fg0},
                        LineNr = {fg = c.fg_light},
                        ColorColumn = {bg = c.none},
                    }
                end
            })
        end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function ()
            require('indent_blankline').setup({
                filetype_exclude = {'help', 'man', 'packer'},
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
        },
        event = 'VimEnter'
    }


    use 'nvim-treesitter/nvim-treesitter'

    -- filetypes
    use {'yochem/prolog.vim', ft = {'prolog'}}

    use {'blankname/vim-fish', ft = {'fish'}}

    use {'vim-python/python-syntax', ft = {'python'}}

    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}}

    use {'chrisbra/csv.vim', ft = {'csv'}}

    use {
        'SmiteshP/nvim-gps',
        config = function()
            require("nvim-gps").setup({disable_icons = true, separator = '.'})
        end
    }

    use 'preservim/vim-markdown'

    use {
        'nmac427/guess-indent.nvim',
        config = function()
            require('guess-indent').setup({tabstop = 4})
        end
    }

    -- use {'theprimeagen/jvim.nvim'}
    use {'/Users/yochem/Documents/jvim.nvim'}

    use {'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle'}

    use {'gbprod/substitute.nvim', config = function ()
        require("substitute").setup()
    end}

    use {
        '/tmp/nvim-lightbulb',
        config = function ()
            require('nvim-lightbulb').setup({
                sign = {enabled = false},
                status_text = {enabled = true},
                autocmd = {enabled = true},
            })
        end
    }

    use {'nvim-lualine/lualine.nvim', config = function ()
        local gps = require('nvim-gps')

        local function lsp()
            if #vim.lsp.buf_get_clients() > 0 then
                return 'LSP'
            end
            return ''
        end

        local function wordcount()
            local ft = vim.bo.filetype
            if ft == 'markdown' or ft == 'text' then
                if vim.fn.wordcount().visual_words then
                    return vim.fn.wordcount().visual_words .. ' words'
                else
                    return vim.fn.wordcount().words .. ' words'
                end
            end
            return ''
        end

        local function filename()
            local ft = vim.bo.filetype
            if ft == 'help' or ft == 'man' then
                return vim.fn.expand('%')
            else
                local fn = vim.fn.expand('%:p')
                fn = fn:gsub('/Users/yochem', '~')

                if fn == '' then
                    return '[No Name]'
                end

                if #fn > 30 then
                    fn = fn:gsub('/(%.?%w%)%w+/', '/%1/', 1)
                end

                return fn
            end
        end

        require('lualine').setup({
            options = {
                icons_enabled = false,
                component_separators = { left = '|', right = '|'},
                section_separators = { left = '', right = ''},
                globalstatus = true,
                theme = 'auto',
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff'},
                lualine_c = {
                    filename,
                    {gps.get_location, cond = gps.is_available}
                },
                lualine_x = {wordcount, 'filetype'},
                lualine_y = {
                    lsp,
                    "require('nvim-lightbulb').get_status_text()",
                    'diagnostics'
                },
                lualine_z = {'location'}
            },
        })
    end}

    use 'lewis6991/spellsitter.nvim'
end)
