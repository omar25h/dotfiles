-------------------------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------------------------

require'packer'.startup(function()
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/completion-treesitter'

  use 'editorconfig/editorconfig-vim'

  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'

  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'

  use 'mileszs/ack.vim'

  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'

  use 'gruvbox-community/gruvbox'
end)

-------------------------------------------------------------------------------------------------
-- General Configuration
-------------------------------------------------------------------------------------------------

vim.o.autoread = true
vim.o.autowrite = true
vim.o.mouse = 'a'
vim.o.path = vim.o.path .. ',**'
vim.o.wildmenu = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.hlsearch = false
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'
vim.o.shortmess = vim.o.shortmess .. 'c'

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes:1'

vim.cmd([[syntax on]])
if vim.wo.diff then
  vim.cmd([[syntax off]])
end

vim.g.mapleader = ','
vim.g.filetype_m = 'objc'

-------------------------------------------------------------------------------------------------
-- Styling
-------------------------------------------------------------------------------------------------

vim.api.nvim_exec ([==[
colorscheme gruvbox
autocmd Filetype NvimTree,Help set signcolumn=no
]==], false)

if vim.fn.getenv("DARKMODE") == "1" then
  vim.api.nvim_exec([[set background=dark]], false)
else
  vim.api.nvim_exec([[set background=light]], false)
end

-------------------------------------------------------------------------------------------------
-- Ack
-------------------------------------------------------------------------------------------------

if vim.fn.executable('rg') then
  vim.g.ackprg='rg --vimgrep'
end

-------------------------------------------------------------------------------------------------
-- Keymap
-------------------------------------------------------------------------------------------------

-- General
vim.api.nvim_set_keymap('', '<C-n>', '<Cmd>cnext<CR>', {})
vim.api.nvim_set_keymap('', '<C-p>', '<Cmd>cprevious<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>a', '<Cmd>cclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ne', '<Cmd>NvimTreeToggle<CR>', { noremap = true })
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
vim.api.nvim_set_keymap('n', '<Leader>fmt', '<Cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', { noremap = true, silent = true })

-- Popup Menu
vim.api.nvim_set_keymap('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

-------------------------------------------------------------------------------------------------
-- Gitgutter
-------------------------------------------------------------------------------------------------

vim.api.nvim_set_keymap('n', ']h', '<Plug>(GitGutterNextHunk)', {})
vim.api.nvim_set_keymap('n', '[h', '<Plug>(GitGutterPrevHunk)', {})

-------------------------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------------------------

local lspconfig = require'lspconfig'
local completion = require'completion'

-- Rust
lspconfig.rust_analyzer.setup{
  on_attach = completion.on_attach,
}

-- C/C++/Objective-C
lspconfig.ccls.setup{
  on_attach = completion.on_attach,
}

-- Golang
lspconfig.gopls.setup{
  on_attach = completion.on_attach,
}

-- JavaScript/TypeScript
lspconfig.tsserver.setup{
  on_attach = completion.on_attach,
}

-- JSON
lspconfig.jsonls.setup{
  on_attach = completion.on_attach,
}

-- Scala
lspconfig.metals.setup{
  on_attach = completion.on_attach,
}

-- Lua
lspconfig.sumneko_lua.setup {
  on_attach = completion.on_attach,
  settings = {
    Lua = {
      diagnostics = {
        disable = {
          "lowercase-global",
          "undefined-global",
        },
      },
    },
  },
}

-- LaTex
lspconfig.texlab.setup{
  on_attach = completion.on_attach,
  settings = {
    latex = {
      build = {
        args = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
          "-output-directory=dist",
        },
        onSave = true,
      },
    },
  },
}

-------------------------------------------------------------------------------------------------
-- Treesitter
-------------------------------------------------------------------------------------------------

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}

