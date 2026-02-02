return {
  dir = '.',
  name = 'paste-image',
  ft = 'markdown',
  config = function()
    vim.api.nvim_create_user_command('PasteImage', function()
      local media_dir = '.media'
      vim.fn.mkdir(media_dir, 'p')
      local filename = os.date '%Y%m%d%H%M%S' .. '.png'
      local filepath = media_dir .. '/' .. filename

      -- Check if WAYLAND_DISPLAY is actually set and wl-paste exists
      local wayland_display = vim.fn.getenv 'WAYLAND_DISPLAY'
      local has_wl_paste = vim.fn.executable 'wl-paste' == 1
      local cmd

      if wayland_display ~= vim.NIL and wayland_display ~= '' and has_wl_paste then
        cmd = string.format('wl-paste > %s', filepath)
      else
        cmd = string.format('xclip -selection clipboard -o > %s', filepath)
      end

      vim.fn.system(cmd)

      local size = vim.fn.getfsize(filepath)
      if size <= 0 then
        vim.notify('Failed to paste image - clipboard is empty', vim.log.levels.ERROR)
        return
      end

      -- Verify it's actually an image using the 'file' command
      local file_type = vim.fn.system('file -b --mime-type ' .. vim.fn.shellescape(filepath)):gsub('%s+', '')
      if not file_type:match '^image/' then
        vim.fn.delete(filepath)
        vim.notify('Clipboard does not contain an image (found: ' .. file_type .. ')', vim.log.levels.ERROR)
        return
      end

      local link = string.format('![](%s)', filepath)
      vim.api.nvim_put({ link }, 'c', true, true)
    end, {})
  end,
}
