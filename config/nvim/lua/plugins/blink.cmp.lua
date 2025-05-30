return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  event = "InsertEnter",
  version = '*',
  opts = {
    keymap = {
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation', 'hide' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-k>'] = {}
    },
    completion = {
      keyword = { range = 'full' },
      menu = {
        draw = {
          treesitter = { 'lsp' },
          padding = { 0, 1 },
          components = {
            kind_icon = {
              text = function(ctx) return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' ' end
            }
          },
          columns = { { 'kind_icon', 'label', 'label_description' } },
        }
      },
      list = { selection = { preselect = false, auto_insert = true } },
      ghost_text = { enabled = true },
    },
    sources = {
      default = { 'omni', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        buffer = {
          -- keep case of first char
          transform_items = function(a, items)
            local keyword = a.get_keyword()
            local correct, case
            if keyword:match('^%l') then
              correct = '^%u%l+$'
              case = string.lower
            elseif keyword:match('^%u') then
              correct = '^%l+$'
              case = string.upper
            else
              return items
            end

            -- avoid duplicates from the corrections
            local seen = {}
            local out = {}
            for _, item in ipairs(items) do
              local raw = item.insertText
              if raw:match(correct) then
                local text = case(raw:sub(1, 1)) .. raw:sub(2)
                item.insertText = text
                item.label = text
              end
              if not seen[item.insertText] then
                seen[item.insertText] = true
                table.insert(out, item)
              end
            end
            return out
          end
        }
      },
    },
    signature = { enabled = true },
  },
}
