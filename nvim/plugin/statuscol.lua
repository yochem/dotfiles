local fmt = string.format

---@type string[]
local diagnostic_signs = vim.diagnostic.config().signs.text
local diagnostic_hl = {
	[vim.diagnostic.severity.HINT] = 'DiagnosticHint',
	[vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
	[vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
	[vim.diagnostic.severity.ERROR] = 'DiagnosticError',
}

local function get_signs(buf, lnum, ns_name)
	local ns = vim.api.nvim_create_namespace(ns_name)
	local start, end_ = { lnum - 1, 0 }, { lnum - 1, -1 }
	return vim.api.nvim_buf_get_extmarks(buf, ns, start, end_, {
		details = true,
		type = 'sign'
	})
end

local function highlight(text, group)
	if not group then
		return text
	end
	return '%#' .. group .. '#' .. text .. '%*'
end

local fold_open_sign = vim.opt.fillchars:get().foldopen
local fold_close_sign = vim.opt.fillchars:get().foldclose

local function get_diagnostic_sign(bufnr, lnum)
	local sign, hl = ' ', ''

  -- short-circuit for the common case that f1 is 0
  local f1 = vim.fn.foldlevel(lnum)
	if f1 > 0 and f1 > vim.fn.foldlevel(lnum - 1) then
		sign = vim.fn.foldclosed(lnum) ~= -1 and fold_close_sign or fold_open_sign
		hl = 'FoldColumn'
	end

	local diags = vim.diagnostic.get(bufnr, { lnum = lnum - 1 })
	if #diags > 0 then
		local worst = diags[1]
		for _, d in ipairs(diags) do
			if d.severity < worst.severity then
				worst = d
			end
		end

		sign = diagnostic_signs[assert(worst.severity)] or ''
		hl = diagnostic_hl[worst.severity]
	end

	return highlight(sign .. ' ', hl)
end

local function get_git_sign(buf, lnum)
	local sign, hl = '│', '@comment'

	local marks = get_signs(buf, lnum, 'gitsigns_signs_')
	if #marks > 0 then
		local detail = assert(marks[1][4])
		sign = (detail.sign_text):gsub('%s+$', '')
		hl = detail.sign_hl_group
	end

	return highlight(sign, hl)
end

local function get_linenr(lnum)
	if vim.v.relnum == 0 then
		local w = math.max(vim.wo.numberwidth - 1, 2)
		return highlight(fmt('%%=%' .. w .. 'd ', lnum), 'CursorLineNr')
	end
	return highlight('%=%l ', 'LineNr')
end

function _G.mystatuscol()
	local lnum = vim.v.lnum
	local buf = vim.api.nvim_get_current_buf()

	if vim.bo[buf].buftype ~= '' or lnum == 0 then
		return ''
	end

	return table.concat({
		get_diagnostic_sign(buf, lnum),
		get_linenr(lnum),
		get_git_sign(buf, lnum),
	}, '')
end

vim.o.statuscolumn = '%{%v:lua.mystatuscol()%}'
