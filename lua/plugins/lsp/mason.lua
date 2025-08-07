return {
  dependencies = {
    { 'mason-org/mason.nvim', version = '^1.0.0' },
    { 'mason-org/mason-lspconfig.nvim', version = '^1.0.0' },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  setup = function(ensure_installed, capabilities)
    require('mason').setup {
      ui = {
        check_outdated_packages_on_open = false,
        -- Add this to see when it's triggered
        border = 'rounded',
      },
    }

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

    require('mason-lspconfig').setup {

      handlers = {
        function(server_name)
          local ok, server = pcall(require, 'plugins.lsp.servers.' .. server_name)
          if not ok or not server then
            server = {}
          end

          capabilities = {}

          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
