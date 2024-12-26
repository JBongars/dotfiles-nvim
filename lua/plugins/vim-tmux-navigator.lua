return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<c-w><c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
    { '<c-w><c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
    { '<c-w><c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
    { '<c-w><c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    { '<c-w><c->', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  },
}
