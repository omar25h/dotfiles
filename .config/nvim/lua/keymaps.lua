-------------------------------------------------------------------------------------------------
-- Keymap
-------------------------------------------------------------------------------------------------

-- General
vim.keymap.set('', '<C-n>', vim.cmd.cnext)
vim.keymap.set('', '<C-p>', vim.cmd.cprevious)
vim.keymap.set('n', '<Leader>c', vim.cmd.cclose)
vim.keymap.set(
  'n',
  '<Leader>ne',
  function() require('nvim-tree.api').tree.toggle { find_file = true, focus = true } end
)
vim.keymap.set('n', '<Leader><Leader>S', function() vim.cmd.source '~/.config/nvim/lua/configs/snippets.lua' end)
vim.keymap.set('n', '<Leader><Leader>w', vim.cmd.w)
vim.keymap.set('n', '<Leader><Leader>x', function() vim.cmd '!%' end)

-- LSP
vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, { silent = true })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { silent = true })
vim.keymap.set('n', '1gD', vim.lsp.buf.type_definition, { silent = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true })
vim.keymap.set('n', 'g0', vim.lsp.buf.document_symbol, { silent = true })
vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol, { silent = true })
vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, { silent = true })
vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { silent = true })
vim.keymap.set('n', '<Leader>fmt', function() vim.lsp.buf.format { async = true } end, { silent = true })
vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, { silent = true })
vim.keymap.set('n', '<Leader>vca', vim.lsp.buf.code_action, { silent = true })

-- Telescope
local telescope = require 'telescope.builtin'

vim.keymap.set('n', '<Leader>ff', telescope.find_files)
vim.keymap.set('n', '<Leader>fg', require('telescope').extensions.live_grep_args.live_grep_args)
vim.keymap.set('n', '<Leader>fb', telescope.buffers)
vim.keymap.set('n', '<Leader>fh', telescope.help_tags)

-- Misc
vim.keymap.set('n', '<Leader>s', require('oh.caser').switch_case, { silent = true })
