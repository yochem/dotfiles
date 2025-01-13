return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    { 'hrsh7th/cmp-omni', lazy = true },
    { 'saghen/blink.compat', lazy = true, opts = {} },
  },
  version = 'v0.*',
  event = "InsertEnter",
  opts = {
    keymap = {
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
      ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
      documentation = { auto_show = true, auto_show_delay_ms = 50 },
      ghost_text = { enabled = true },
    },
    sources = {
      default = { 'omni', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        omni = {
          name = 'omni',
          module = 'blink.compat.source',
          score_offset = 10,
          opts = {},
        }
      },
    },
    signature = { enabled = true },
  },
}
