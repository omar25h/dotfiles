-------------------------------------------------------------------------------------------------
-- General Configuration
-------------------------------------------------------------------------------------------------

vim.o.autoread = true
vim.o.autowrite = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.cursorline = true
vim.o.cursorlineopt = 'number'
vim.o.exrc = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.list = true
vim.o.mouse = 'nvi'
vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.wildmenu = true
vim.opt.fillchars = { eob = '·' }
vim.opt.listchars = { nbsp = '␣', trail = '·', tab = '» ' }
vim.opt.path:append ',**'
vim.opt.shortmess:append 'c'

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes:1'

vim.g.filetype_m = 'objc'
vim.g.tex_flavor = 'latex'

local highlight_yank = vim.api.nvim_create_augroup('highlightYank', { clear = true })
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = highlight_yank,
  callback = function() vim.highlight.on_yank { higroup = 'Visual', timeout = 200 } end,
})

-- Open terminal in insert mode without line numbers
-- autocmd TermOpen * startinsert
local term_autocmds = vim.api.nvim_create_augroup('Term', { clear = true })
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  group = term_autocmds,
  callback = function()
    vim.cmd.startinsert()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = 'no'
  end,
})

-------------------------------------------------------------------------------------------------
-- Styling
-------------------------------------------------------------------------------------------------

vim.cmd.colorscheme 'gruvbox'

local function get_background() return vim.fn.getenv 'DARKMODE' == '1' and 'dark' or 'light' end

vim.o.background = get_background()
