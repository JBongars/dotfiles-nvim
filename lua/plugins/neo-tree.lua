-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    event_handlers = {
      -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#auto-close-on-open-file
      {
        event = 'file_open_requested',
        handler = function()
          -- auto close
          -- vim.cmd("Neotree close")
          -- OR
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
      {
        event = 'neo_tree_buffer_enter',
        handler = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true
        end,
      },
    },
    filesystem = {
      window = {
        position = 'right',
        auto_close = true,
        width = 60,
        mappings = {
          ['\\'] = 'close_window',

          ['Y'] = function(state)
            -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
            -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local results = {
              filepath,
              modify(filepath, ':.'),
              modify(filepath, ':~'),
              filename,
              modify(filename, ':r'),
              modify(filename, ':e'),
            }

            -- absolute path to clipboard
            local i = vim.fn.inputlist {
              'Choose to copy to clipboard:',
              '1. Absolute path: ' .. results[1],
              '2. Path relative to CWD: ' .. results[2],
              '3. Path relative to HOME: ' .. results[3],
              '4. Filename: ' .. results[4],
              '5. Filename without extension: ' .. results[5],
              '6. Extension of the filename: ' .. results[6],
            }

            if i > 0 then
              local result = results[i]
              if not result then
                return print('Invalid choice: ' .. i)
              end
              vim.fn.setreg('"', result)
              vim.notify('Copied: ' .. result)
            end
          end,
        },
      },
    },
  },
}
