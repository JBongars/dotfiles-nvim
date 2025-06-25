-- sync remote and local system paste

--   vim.g.clipboard = {
--     name = 'OSC 52',
--     copy = {
--       ['+'] = require('vim.ui.clipboard.osc52').copy '+',
--       ['*'] = require('vim.ui.clipboard.osc52').copy '*',
--     },
--     paste = {
--       ['+'] = require('vim.ui.clipboard.osc52').paste '+',
--       ['*'] = require('vim.ui.clipboard.osc52').paste '*',
--     },
--   }
--
--   vim.opt.clipboard = 'unnamedplus'
-- end)

vim.schedule(function()
  vim.g.clipboard = {
    name = 'tmux',
    copy = {
      ['+'] = { 'tmux', 'load-buffer', '-' },
      ['*'] = { 'tmux', 'load-buffer', '-' },
    },
    paste = {
      ['+'] = { 'tmux', 'save-buffer', '-' },
      ['*'] = { 'tmux', 'save-buffer', '-' },
    },
  }
  vim.opt.clipboard = 'unnamedplus'
end)
