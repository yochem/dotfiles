local function path()
    local val = vim.fn.expand('%:p'):gsub(vim.env.HOME, '~')
    return val ~= '' and val or '[No Name]'
end

local statusline = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {path},
    lualine_x = {
        {
            'diagnostics',
            sources = {'nvim_lsp'},
            symbols = {error = 'E:', warn = 'W:', info = 'I:'},
            color_error = '#E06C75',
            color_warn = '#E5C07B',
            color_info = '#ABB2BF'
        }
    },
    lualine_y = {'filetype'},
    lualine_z = {'location'}
}

require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'onedark',
        section_separators = '',
        component_separators = ''
    },
    sections = statusline,
    inactive_sections = vim.deepcopy(statusline)
}
