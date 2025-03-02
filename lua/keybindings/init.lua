-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- center screen everytime I jump vertically
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', 'j', 'jzz', { noremap = true })
vim.keymap.set('n', 'k', 'kzz', { noremap = true })
vim.keymap.set('n', 'n', 'nzz', { noremap = true })
vim.keymap.set('n', 'N', 'Nzz', { noremap = true })
vim.keymap.set('n', '}', '}zz', { noremap = true })
vim.keymap.set('n', '{', '{zz', { noremap = true })
vim.keymap.set('n', 'G', 'Gzz', { noremap = true })
vim.keymap.set('n', 'gg', 'ggzz', { noremap = true })
vim.keymap.set('n', '%', '%zz', { noremap = true })

vim.keymap.set('v', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('v', '<C-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('v', 'j', 'jzz', { noremap = true })
vim.keymap.set('v', 'k', 'kzz', { noremap = true })
vim.keymap.set('v', 'n', 'nzz', { noremap = true })
vim.keymap.set('v', 'N', 'Nzz', { noremap = true })
vim.keymap.set('v', '}', '}zz', { noremap = true })
vim.keymap.set('v', '{', '{zz', { noremap = true })
vim.keymap.set('v', 'G', 'Gzz', { noremap = true })
vim.keymap.set('v', 'gg', 'ggzz', { noremap = true })
vim.keymap.set('v', '%', '%zz', { noremap = true })

-- Map multiple repeats of H/L/J/K to corresponding window resizes
for i = 1, 10 do
  vim.keymap.set('n', '<C-w>' .. string.rep('L', i), 10 * i .. '<C-w><', { silent = true })
  vim.keymap.set('n', '<C-w>' .. string.rep('H', i), 10 * i .. '<C-w>>', { silent = true })
  vim.keymap.set('n', '<C-w>' .. string.rep('K', i), 10 * i .. '<C-w>+', { silent = true })
  vim.keymap.set('n', '<C-w>' .. string.rep('J', i), 10 * i .. '<C-w>-', { silent = true })
end

-- Fold logic
vim.keymap.set('n', 'zC', ':g/{/normal zf%<CR>', { noremap = true, silent = true })
