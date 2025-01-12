-- Buffer Management Configuration
return {
  {
    'tiagovla/scope.nvim',
    config = function()
      -- Basic vim options for buffer management
      vim.opt.hidden = true
      vim.opt.switchbuf = 'useopen,usetab'
      vim.opt.autowrite = true

      -- Initialize scope
      require('scope').setup()

      -- Key mappings for buffer navigation (Emacs-style)
      vim.keymap.set('n', '<Leader>bn', ':bnext<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>bp', ':bprevious<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>bb', ':buffers<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>bl', ':ls<CR>:b<Space>', { noremap = true })

      -- Use bufdelete.nvim for better buffer deletion behavior
      vim.keymap.set('n', '<Leader>bd', ':Bdelete<CR>', { noremap = true, silent = true })

      -- Switch to previous buffer in current window
      vim.keymap.set('n', '<Leader><Leader>', '<C-^>', { noremap = true, silent = true })

      -- List all buffers and select one to switch to
      vim.keymap.set('n', '<Leader>bs', ':buffers<CR>:buffer<Space>', { noremap = true })

      -- Create enhanced buffer list command
      vim.api.nvim_create_user_command('Buffers', function()
        local buffers = vim.fn.getbufinfo { buflisted = 1 }
        local current_buf = vim.fn.bufnr '%'
        local lines = {}

        for _, buf in ipairs(buffers) do
          local icon = buf.bufnr == current_buf and '*' or ' '
          local name = buf.name ~= '' and vim.fn.fnamemodify(buf.name, ':~:.') or '[No Name]'
          local modified = buf.changed == 1 and '+' or ' '
          table.insert(lines, string.format('%s%3d %s %s', icon, buf.bufnr, modified, name))
        end

        vim.ui.select(lines, {
          prompt = 'Select buffer:',
          format_item = function(item)
            return item
          end,
        }, function(choice)
          if choice then
            local bufnr = tonumber(choice:match '%d+')
            if bufnr then
              vim.api.nvim_set_current_buf(bufnr)
            end
          end
        end)
      end, {})
    end,
  },
  {
    'famiu/bufdelete.nvim',
  },
}
