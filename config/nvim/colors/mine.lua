vim.cmd.runtime('colors/default.lua')

---@param group string
---@param opts vim.api.keyset.highlight
local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

hl('LineNr', { fg = 'NvimLightGray3' })
hl('CursorLineNr', { fg = 'Orange' })
hl('CursorLine', { bg = nil })
hl('FoldColumn', { fg = 'NvimLightGray4' })
hl('Folded', { bg = nil })

hl('Normal', { fg = 'White', bg = nil })
hl('NormalFloat', { fg = 'White', bg = 'NvimDarkGray3' })
hl('Function', { fg = 'NvimLightBlue' })
hl('Identifier', { fg = 'White' })
hl('Delimiter', { fg = 'White' })
hl('Constant', { fg = 'NvimLightYellow' })
-- hl('Statement', { fg = 'NvimLightMagenta' })
hl('Special', { link = 'Constant' })
hl('@lsp.mod.declaration', { bold = false })
hl('@string.documentation', { link = '@comment' })
hl('@comment.todo', { fg = 'NvimLightRed', bold = true })

hl('@constructor.lua', { link = 'Delimiter' })
hl('@constructor.python', { link = 'Function' })
hl('@variable', { fg = 'White' })
-- hl('@variable.parameter', { fg = 'NvimLightCyan' })

hl('Directory', { fg = 'NvimLightBlue' })

hl('TroubleNormal', { link = 'Normal' })
hl('TroubleNormalNC', { link = 'Normal' })

hl('VisualNonText', { fg = 'Grey', bg = 'NvimDarkGrey4' })
