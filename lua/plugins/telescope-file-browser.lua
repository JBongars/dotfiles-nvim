return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  extensions = {
    file_browser = {
      theme = 'ivy',
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      initial_mode = 'normal',
      mappings = {
        ['i'] = { -- Insert mode mappings
          ['<C-n>'] = 'create', -- Create a new file/directory
          ['<C-r>'] = 'rename', -- Rename file/directory
          ['<C-d>'] = 'delete', -- Delete file/directory
          ['<C-y>'] = 'copy', -- Copy file
        },
        ['n'] = { -- Normal mode mappings
          ['n'] = 'create', -- Create a new file/directory
          ['r'] = 'rename', -- Rename file/directory
          ['d'] = 'delete', -- Delete file/directory
          ['y'] = 'copy', -- Copy file
          ['<CR>'] = 'select_default', -- Open file/directory
        },
      },
    },
  },
  config = function()
    vim.api.nvim_create_user_command('Ex', function(opts)
      local target_dir = opts.args
      local current_file = vim.api.nvim_buf_get_name(0)
      local directory = vim.fn.fnamemodify(current_file, ':p:h')

      if directory == '' then
        directory = vim.fn.getcwd()
      end

      local combined_dir = vim.fn.resolve(directory .. '/' .. target_dir)
      if vim.fn.isdirectory(combined_dir) then
        directory = combined_dir
      end

      require('telescope').extensions.file_browser.file_browser { cwd = directory }
    end, {})

    vim.api.nvim_create_user_command('Exg', function()
      require('telescope').extensions.file_browser.file_browser()
    end, {})
  end,
}
