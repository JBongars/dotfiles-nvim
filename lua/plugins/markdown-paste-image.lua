return {
  dir = '.',
  name = 'paste-image',
  ft = 'markdown',
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.keymap.set('n', '<leader>pi', function()
          local media_dir = vim.fn.expand '%:p:h' .. '/.media'
          vim.fn.mkdir(media_dir, 'p')

          local filename = os.date '%Y%m%d%H%M%S' .. '-image.png'
          local filepath = media_dir .. '/' .. filename

          local base64 = vim.fn.getreg '+'
          base64 = base64:gsub('^data:image/[^;]+;base64,', '')
          base64 = base64:gsub('%s+', '')

          local handle = io.popen('base64 -d > ' .. vim.fn.shellescape(filepath), 'w')
          handle:write(base64)
          handle:close()

          -- Insert at cursor position
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          local line = vim.api.nvim_get_current_line()
          local before = line:sub(1, col)
          local after = line:sub(col + 1)
          local link = '![](.media/' .. filename .. ')'

          vim.api.nvim_set_current_line(before .. link .. after)
          -- Position cursor inside [] and enter insert mode
          vim.api.nvim_win_set_cursor(0, { row, col + 2 })
          vim.cmd 'startinsert'
        end, { buffer = true, desc = 'Paste base64 image' })
      end,
    })
  end,
}
