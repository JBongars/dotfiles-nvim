-- sync remote and local system paste

-- to include, do
-- :luafile ./remote-init.lua

-- to test if osc52 is working, use following command and paste somewhere, you should see "hello world"
-- printf $'\e]52;c;%s\a' "$(base64 <<<'hello world')"

-- vim.schedule(function()
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy '+',
--     ['*'] = require('vim.ui.clipboard.osc52').copy '*',
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste '+',
--     ['*'] = require('vim.ui.clipboard.osc52').paste '*',
--   },
-- }

-- local function paste()
--   return { vim.fn.split(vim.fn.getreg '', '\n'), vim.fn.getregtype '' }
-- end
--
-- local osc52 = require 'vim.ui.clipboard.osc52'
--
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = osc52.copy '+',
--     ['*'] = osc52.copy '*',
--   },
--   paste = {
--     ['+'] = paste,
--     ['*'] = paste,
--   },
-- }
--
-- end)

vim.g.clipboard = 'osc52'
--
-- vim.schedule(function()
--   vim.g.clipboard = {
--     name = 'tmux',
--     copy = {
--       ['+'] = { 'tmux', 'load-buffer', '-' },
--       ['*'] = { 'tmux', 'load-buffer', '-' },
--     },
--     paste = {
--       ['+'] = { 'tmux', 'save-buffer', '-' },
--       ['*'] = { 'tmux', 'save-buffer', '-' },
--     },
--   }
--   vim.opt.clipboard = 'unnamedplus'
-- end)

-- vim.opt.clipboard = 'unnamedplus'
vim.opt.clipboard = ''
