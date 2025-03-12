return {
  config = {
    'nvim-java/nvim-java',
  },
  after = function()
    local java17_path = '/usr/local/bin/java17'
    local java_home = vim.fn.expand '$JAVA_HOME'
    local java17_exists = vim.fn.executable(java17_path) == 1

    -- Set JAVA_HOME environment variable for the Neovim process
    if java17_exists then
      -- If java17 exists, set JAVA_HOME to its parent directory
      vim.env.JAVA_HOME = vim.fn.fnamemodify(java17_path, ':h:h')
    end

    -- Set JDTLS specific Java home
    local javaobj = {
      {
        name = java17_exists and 'Java17' or 'JAVA_HOME',
        path = java17_exists and vim.env.JAVA_HOME or java_home,
        default = true,
      },
    }

    require('lspconfig').jdtls.setup {
      cmd = {
        -- Explicitly tell jdtls which Java to use
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '-Xmx2g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration',
        vim.fn.stdpath 'data' .. '/mason/packages/jdtls/config_mac',
        '-data',
        vim.fn.expand '~/.cache/jdtls-workspace',
      },
      cmd_env = {
        JAVA_HOME = java17_exists and vim.env.JAVA_HOME or java_home,
      },
      settings = {
        java = {
          configuration = {
            runtimes = javaobj,
          },
        },
      },
    }
  end,
}
