# TODO

- Mason should only check for updates once a week not everytime I open vim
- relative line numbers are almost invisible
- better buffer management (emacs style buffer management?)
  - Should panes hold their own buffer order? As in close buffer on pane it will return to previous buffer for that pane
- worktree should show hidden files

- Fix markdown configuration. Current one doesn't seem to be able to write to files
  - you need .markdownlint file or something with rules. but still bombarded by a lot of noise linting
  - global disable rules
    - MD013 (paragraph extends to far accross the screen)
- Folding require you to create fold with f{zf% , feel like LSP should be doing this instead
- fzf includes folders like node_modules. Need to blacklist these folders from all search results. Considering including all files in .gitignore
- Using :bd closes the current buffer and the current pane. :bd should only close the current pane
- :e ./foo should refer to relative path from current buffer. Not the project directory. foo should refer to project directory
- disable quotes auto closing (I think maybe this is an LSP issue?)

## LOW PRIORITY

- Consider finish setup of tmux-nvim shared buffers
- Setup priliminary emacs config
