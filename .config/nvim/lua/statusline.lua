local function path()
    local full_path = vim.fn.expand('%:p'):gsub(vim.env.HOME, '~')
    local val = full_path ~= '' and full_path or '[No Name]'
    val = vim.bo.filetype == 'help' and vim.fn.expand('%:t') or val

    if vim.bo.modified then
        val = val .. ' [+]'
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        val = val .. ' [-]'
    end
    return val
end

local options = {
    icons_enabled = false,
    theme = 'onedark',
    section_separators = '',
    component_separators = ''
}

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
    options = options,
    sections = statusline,
    inactive_sections = vim.deepcopy(statusline)
}
