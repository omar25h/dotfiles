-------------------------------------------------------------------------------------------------
-- Keymap
-------------------------------------------------------------------------------------------------

-- General
vim.keymap.set('', '<C-n>', vim.cmd.cnext, { desc = 'Goto next error' })
vim.keymap.set('', '<C-p>', vim.cmd.cprevious, { desc = 'Goto previous error' })
vim.keymap.set('n', '<Leader>c', vim.cmd.cclose, { desc = 'Close quickfix window' })
vim.keymap.set(
  'n',
  '<Leader>ne',
  function() require('nvim-tree.api').tree.toggle { find_file = true, focus = true } end,
  { desc = 'Toggle nvim-tree' }
)
vim.keymap.set('n', '<Leader><Leader>s', require('oh.snippets').reload_snippets, { desc = 'Reload snippets' })
vim.keymap.set('n', '<Leader><Leader>w', vim.cmd.w, { desc = 'Write file' })
vim.keymap.set('n', '<Leader><Leader>x', function() vim.cmd '!%' end, { desc = 'Execute current file' })

-- LSP
vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, { silent = true, desc = 'Goto definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, desc = 'Hover' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true, desc = 'Goto implementation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { silent = true, desc = 'Signature help' })
vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, { silent = true, desc = 'Goto type definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true, desc = 'Goto references' })
vim.keymap.set('n', 'g0', vim.lsp.buf.document_symbol, { silent = true, desc = 'List document symbols' })
vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol, { silent = true, desc = 'List workspace symbols' })
vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, { silent = true, desc = 'Goto declaration' })
vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { silent = true, desc = 'Rename symbol' })
vim.keymap.set(
  'n',
  '<Leader>fmt',
  function() vim.lsp.buf.format { async = true } end,
  { silent = true, desc = 'Format' }
)
vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, { silent = true, desc = 'Add diagnostic to buffer list' })
vim.keymap.set('n', '<Leader>vca', vim.lsp.buf.code_action, { silent = true, desc = 'Execute code action' })

-- Telescope
local telescope = require 'telescope.builtin'

vim.keymap.set('n', '<Leader>ff', telescope.find_files, { desc = 'Find files' })
vim.keymap.set(
  'n',
  '<Leader>fg',
  require('telescope').extensions.live_grep_args.live_grep_args,
  { desc = 'Live grep files' }
)
vim.keymap.set('n', '<Leader>fb', telescope.buffers, { desc = 'List buffers' })
vim.keymap.set('n', '<Leader>fh', telescope.help_tags, { desc = 'List help tags' })

-- Misc
vim.keymap.set('n', '<Leader>s', require('oh.caser').switch_case, { silent = true, desc = 'Switch case' })
