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

          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities or {}, server.capabilities or {})

          vim.lsp.config(server_name, server)
          vim.lsp.enable(server_name)
        end,
      },
    }
  end,
}
