-------------------------------------------------------------------------------------------------
-- Keymap
-------------------------------------------------------------------------------------------------

-- General
vim.keymap.set('', '<C-n>', '<Cmd>cnext<CR>', {})
vim.keymap.set('', '<C-p>', '<Cmd>cprevious<CR>', {})
vim.keymap.set('n', '<Leader>a', '<Cmd>cclose<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ne', '<Cmd>NvimTreeFindFileToggle<CR>', { noremap = true })
vim.keymap.set('n', '<C-S-T>', '<Cmd>vs<bar>:b#<CR>', {})
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('n', '<Leader><Leader>s', '<Cmd>source ~/.config/nvim/lua/configs/snippets.lua<CR>', { noremap = true })
vim.keymap.set('n', '<Leader><Leader>w', '<Cmd>w<CR>', { noremap = true })
vim.keymap.set('n', '<Leader><Leader>x', '<Cmd>!%<CR>', { noremap = true })

-- LSP
vim.keymap.set('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '1gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'g0', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gW', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>fmt', '<Cmd>lua vim.lsp.buf.format{ async = true }<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>dl', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>vca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

-- Popup Menu
vim.keymap.set('i', '<Tab>', [[pumvisible() ? '\<C-n>' : '<Tab>']], { noremap = true, expr = true })
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? '\<C-p>' : '<S-Tab>']], { noremap = true, expr = true })

-- Telescope
vim.keymap.set('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>fg', '<Cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>fb', '<Cmd>Telescope buffers<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>fh', '<Cmd>Telescope help_tags<CR>', { noremap = true })

