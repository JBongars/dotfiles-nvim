local servers = {
  --  gopls = {},
  pyright = require 'plugins.lsp.servers.pyright',
  --  rust_analyzer = {},
  lua_ls = require 'plugins.lsp.servers.lua',
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua', -- Used to format Lua code
  require('plugins.lint').dependencies,
})

local function after()
  require('plugins.nvim-java').after()
end

return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    require('plugins.lsp.mason').dependencies,

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Allows extra capabilities provided by nvim-cmp
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        require 'plugins.lsp.keymaps'(event)
      end,
    })

    mason = require 'plugins.lsp.mason'
    mason.setup(ensure_installed, capabilities)

    -- Change diagnostic symbols in the sign column (gutter)
    -- if vim.g.have_nerd_font then
    --   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
    --   local diagnostic_signs = {}
    --   for type, icon in pairs(signs) do
    --     diagnostic_signs[vim.diagnostic.severity[type]] = icon
    --   end
    --   vim.diagnostic.config { signs = { text = diagnostic_signs } }
    -- end

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    after()
  end,
}
