-------------------------------------------------------------------------------------------------
-- Keymap
-------------------------------------------------------------------------------------------------

local map = vim.keymap.set

-- General
map('n', '<C-n>', function() pcall(vim.cmd.cnext) end, { desc = 'Goto next error' })
map('n', '<C-p>', function() pcall(vim.cmd.cprevious) end, { desc = 'Goto previous error' })
map('n', '<Leader>c', vim.cmd.cclose, { desc = 'Close quickfix window' })
map('n', '<Leader><Leader>w', vim.cmd.w, { desc = 'Write file' })
map('n', '<Leader><Leader>x', function() vim.cmd '!%' end, { desc = 'Execute current file' })

-- LSP
map('n', '<C-]>', vim.lsp.buf.definition, { silent = true, desc = 'Goto definition' })
map('n', 'gi', vim.lsp.buf.implementation, { silent = true, desc = 'Goto implementation' })
map('n', '<C-k>', vim.lsp.buf.signature_help, { silent = true, desc = 'Signature help' })
map('n', 'gD', vim.lsp.buf.type_definition, { silent = true, desc = 'Goto type definition' })
map('n', 'gr', vim.lsp.buf.references, { silent = true, desc = 'Goto references' })
map('n', 'g0', vim.lsp.buf.document_symbol, { silent = true, desc = 'List document symbols' })
map('n', 'gW', vim.lsp.buf.workspace_symbol, { silent = true, desc = 'List workspace symbols' })
map('n', 'gd', vim.lsp.buf.declaration, { silent = true, desc = 'Goto declaration' })
map('n', '<Leader>rn', vim.lsp.buf.rename, { silent = true, desc = 'Rename symbol' })
map('n', '<Leader>fmt', function() vim.lsp.buf.format { async = true } end, { silent = true, desc = 'Format' })

map('n', '<Leader><Leader>a', vim.lsp.buf.code_action, { silent = true, desc = 'Execute code action' })

-- Diagnostic
map('n', '<Leader>dl', vim.diagnostic.setloclist, { silent = true, desc = 'Add diagnostic to buffer list' })
map('n', '<Leader>do', vim.diagnostic.open_float, { noremap = true, silent = true, desc = 'Open diagnostic' })
map('n', '<Leader>d[', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = 'Go to previous diagnostic' })
map('n', '<Leader>d]', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = 'Go to next diagnostic' })

-- Misc
map('n', '<Leader>s', require('oh.caser').switch_case, { silent = true, desc = 'Switch case' })
