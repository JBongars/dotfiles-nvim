return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      markdown = { 'prettier' },
    },
    format_on_save = {
      pattern = '*.md',
      timeout_ms = 500,
    },
  },
}
