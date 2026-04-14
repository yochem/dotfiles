local function get_signs(buf, lnum, ns_ids)
  local all = {}
  local start, end_ = { lnum - 1, 0 }, { lnum - 1, -1 }
  for _, ns in ipairs(ns_ids) do
    local marks = vim.api.nvim_buf_get_extmarks(buf, ns, start, end_, {
      details = true,
      type = 'sign'
    })
    all = vim.list_extend(all, marks)
  end
  return all
end

local function highlight(text, group)
  if not group then
    return text
  end
  return '%#' .. group .. '#' .. text .. '%*'
end

local fold_open_sign = vim.opt.fillchars:get().foldopen .. ' '
local fold_close_sign = vim.opt.fillchars:get().foldclose .. ' '

local function get_diagnostic_sign(buf, lnum)
  local sign, hl = '  ', 'SignColumn'

  -- short-circuit for the common case that f1 is 0
  local f1 = vim.fn.foldlevel(lnum)
  if f1 > 0 and f1 > vim.fn.foldlevel(lnum - 1) then
    sign = vim.fn.foldclosed(lnum) ~= -1 and fold_close_sign or fold_open_sign
    hl = 'FoldColumn'
  end

  local diagnostic_ns = {}
  for name, id in pairs(vim.api.nvim_get_namespaces()) do
    if name:find('diagnostic.signs', 1, true) then
      diagnostic_ns[#diagnostic_ns + 1] = id
    end
  end
  local diags = get_signs(buf, lnum, diagnostic_ns)

  if #diags > 0 then
    local worst_prio = -1
    for _, d in ipairs(diags) do
      local prio = d[4].priority
      if prio > worst_prio then
        sign = d[4].sign_text or '•'
        hl = d[4].sign_hl_group or 'Error'
        worst_prio = prio
      end
    end
  end

  local ca_marks = get_signs(buf, lnum, {
    vim.api.nvim_create_namespace('yochem.lsp.code_actions')
  })
  if #ca_marks > 0 then
    sign = assert(ca_marks[1][4]).sign_text
    hl = assert(ca_marks[1][4]).sign_hl_group
  end

  return highlight(sign, hl)
end

local function get_git_sign(buf, lnum)
  local sign, hl = '│', '@comment'

  local ns = vim.api.nvim_create_namespace('gitsigns_signs_')
  local marks = get_signs(buf, lnum, { ns })
  if #marks > 0 then
    local detail = assert(marks[1][4])
    sign = (detail.sign_text):gsub('%s+$', '')
    hl = detail.sign_hl_group
  end

  return highlight(sign, hl)
end

local function get_linenr(lnum, is_relative)
  if is_relative then
    local w = math.max(vim.wo.numberwidth - 1, 2)
    return highlight(string.format('%%=%' .. w .. 'd', lnum), 'CursorLineNr')
  end
  return highlight('%=%l', 'LineNr')
end

function _G.mystatuscol()
  local lnum = vim.v.lnum
  local buf = vim.api.nvim_get_current_buf()

  if vim.bo[buf].buftype ~= '' or lnum == 0 then
    return ''
  end

  return table.concat({
    get_diagnostic_sign(buf, lnum),
    get_linenr(lnum, vim.v.relnum == 0),
    get_git_sign(buf, lnum),
  }, '')
end

vim.o.statuscolumn = '%{%v:lua.mystatuscol()%}'
