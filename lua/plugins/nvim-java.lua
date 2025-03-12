return {
  config = {
    'nvim-java/nvim-java',
    config = function()
      local java17_path = '/usr/local/bin/java17'
      local java_home = vim.fn.expand '$JAVA_HOME'

      -- Check if java17 exists at the specified path
      local java17_exists = vim.fn.executable(java17_path) == 1

      require('java').setup {
        jdk = {
          -- Use Java 17 if available, otherwise fall back to JAVA_HOME
          home = java17_exists and vim.fn.fnamemodify(java17_path, ':h:h') or java_home,
        },
        debug = {
          enable = true,
        },
      }
    end,
  },
  after = function()
    local java17_path = '/usr/local/bin/java17'
    local java_home = vim.fn.expand '$JAVA_HOME'
    local java17_exists = vim.fn.executable(java17_path) == 1

    require('lspconfig').jdtls.setup {
      cmd_env = {
        JAVA_HOME = java17_exists and vim.fn.fnamemodify(java17_path, ':h:h') or java_home,
      },
    }
  end,
}
