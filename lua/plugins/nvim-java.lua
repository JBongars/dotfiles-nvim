return {
  config = {
    'nvim-java/nvim-java',
    config = function()
      require('java').setup {
        jdk = {
          home = vim.fn.expand '$JAVA_HOME',
        },
        debug = {
          enable = true,
        },
      }
    end,
  },
  after = function()
    require('lspconfig').jdtls.setup {}
  end,
}
