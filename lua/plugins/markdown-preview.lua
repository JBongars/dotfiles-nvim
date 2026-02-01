return {
  'iamcco/markdown-preview.nvim',
  -- May need to open any markdown file and run on first install
  -- :call mkdp#util#install()
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
}
