local function load_keybindings()
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
end

return {
  dependencies = {
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },

  install = function(telescope)
    print 'installing telescope.file_browser...'

    telescope.load_extension 'file_browser'
    local fb_actions = telescope.extensions.file_browser.actions

    load_keybindings()

    return {
      'nvim-telescope/telescope-file-browser.nvim',
      dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-lua/plenary.nvim',
      },
      extensions = {
        file_browser = {
          theme = 'ivy',
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          initial_mode = 'normal',
          mappings = {
            ['i'] = { -- Insert mode mappings
              ['<C-n>'] = fb_actions.create, -- Create a new file/directory
              ['<C-r>'] = fb_actions.rename, -- Rename file/directory
              ['<C-d>'] = fb_actions.remove, -- Delete file/directory
              ['<C-y>'] = fb_actions.copy, -- Copy file
            },
            ['n'] = { -- Normal mode mappings
              ['n'] = fb_actions.create, -- Create a new file/directory
              ['r'] = fb_actions.rename, -- Rename file/directory
              ['d'] = fb_actions.remove, -- Delete file/directory
              ['y'] = fb_actions.copy, -- Copy file
              -- ['<CR>'] = fb_actions.select_default, -- Open file/directory
            },
          },
        },
      },
    }
  end,
}
