return {
  'm00qek/baleia.nvim',
  version = '*',
  config = function()
    vim.g.baleia = require('baleia').setup {
      strip_ansi_codes = true,
    }

    vim.api.nvim_create_user_command('AnsiEsc', function()
      local buf = vim.api.nvim_get_current_buf()
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.g.baleia.once(buf)
    end, { bang = true })

    vim.api.nvim_create_user_command('AnsiLogs', vim.g.baleia.logger.show, { bang = true })
  end,
}

-- no super great
-- return {
--   '0xferrous/ansi.nvim',
--   config = function()
--     require('ansi').setup {
--       auto_enable = false, -- Auto-enable for configured filetypes
--       theme = 'catpuccin',
--       filetypes = { 'log', 'ansi' }, -- Filetypes to auto-enable
--     }
--   end,
-- }
