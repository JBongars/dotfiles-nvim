-- Used for folding/unfolding blocks of code using LSP instead of :g/{/normal zf%
return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  config = function()
    require('ufo').setup {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    }

    -- Optional: better folding preview
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Optional: keymaps
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
  end,
}
