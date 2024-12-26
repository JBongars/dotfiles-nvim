return {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Send folding info through LSP
      fold = true,
      -- or
      semantic = {
        enable = true,
        annotations = true,
        disable = false,
      },
    },
  },
}
