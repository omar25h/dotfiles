-------------------------------------------------------------------------------------------------
-- Keymap
-------------------------------------------------------------------------------------------------

-- General
vim.api.nvim_set_keymap('', '<C-n>', '<Cmd>cnext<CR>', {})
vim.api.nvim_set_keymap('', '<C-p>', '<Cmd>cprevious<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>a', '<Cmd>cclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ne', '<Cmd>NvimTreeFindFileToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-T>', '<Cmd>vs<bar>:b#<CR>', {})
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- LSP
vim.api.nvim_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '1gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g0', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gW', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fmt', '<Cmd>lua vim.lsp.buf.format{ async = true }<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', { noremap = true, silent = true })

-- Popup Menu
vim.api.nvim_set_keymap('i', '<Tab>', [[pumvisible() ? '\<C-n>' : '<Tab>']], { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? '\<C-p>' : '<S-Tab>']], { noremap = true, expr = true })

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', '<Cmd>Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', '<Cmd>Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', '<Cmd>Telescope help_tags<CR>', { noremap = true })

