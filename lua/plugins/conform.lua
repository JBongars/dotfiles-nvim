return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      markdown = { 'dprint' },
    },
    format_on_save = {
      pattern = '*.md',
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
