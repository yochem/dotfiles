vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('read-only', {}),
  callback = function(ev)
    local gitattr = vim.fs.find('.gitattributes', { upward = true, type = 'file' })[1]
    local p = vim.fs.relpath(vim.fs.dirname(gitattr or ''), ev.file)
    if not gitattr or not p then
      return
    end

    for line in io.lines(gitattr) do
      local pattern, attr = unpack(vim.split(line, ' '))
      if vim.glob.to_lpeg(pattern):match(p) then
        if attr:find('generated', 1, true) then
          vim.notify_once('Warning: Opening generated file in read-only mode', 3)
          vim.bo[ev.buf].readonly = true
        end
      end
    end
  end
})
