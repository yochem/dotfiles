vim.keymap.set('n', '<leader>e', function ()
  local envs = { 'production', 'acceptance', 'testing', 'development' }
  local buf = vim.api.nvim_buf_get_name(0)

  local current_env, left_part, right_part
  for i, env in ipairs(envs) do
    local start = buf:match('.*' .. env)
    if start then
      table.remove(envs, i)
      current_env = env
      left_part = vim.fs.dirname(start)
      right_part = vim.fs.relpath(start, buf)
    end
  end

  vim.ui.select(envs, {}, function (choice)
    vim.cmd.vsplit(vim.fs.joinpath(left_part, choice, right_part))
  end)
end)
