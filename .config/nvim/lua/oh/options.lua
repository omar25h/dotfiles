-------------------------------------------------------------------------------------------------
-- General Configuration
-------------------------------------------------------------------------------------------------

vim.o.autoread = true
vim.o.autowrite = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.cursorline = true
vim.o.cursorlineopt = 'number'
vim.o.expandtab = true
vim.o.exrc = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.list = true
vim.o.mouse = 'nvi'
vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
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

local augroup_fold = vim.api.nvim_create_augroup('fold', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost' }, {
  group = augroup_fold,
  callback = function()
    vim.wo.foldenable = true
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.wo.foldmethod = 'expr'

    -- Update all folds and expand
    vim.cmd.normal 'zxzR'
  end,
})

local highlight_yank = vim.api.nvim_create_augroup('highlightYank', { clear = true })
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = highlight_yank,
  callback = function() vim.highlight.on_yank { higroup = 'Visual', timeout = 200 } end,
})
