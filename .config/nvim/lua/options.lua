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
vim.o.mouse = 'nvi'
vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.wildmenu = true
vim.opt.path:append ',**'
vim.opt.shortmess:append 'c'

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes:1'

vim.g.filetype_m = 'objc'
vim.g.tex_flavor = 'latex'

local filetype_group = vim.api.nvim_create_augroup('Filetype', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = filetype_group,
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})

local highlight_yank = vim.api.nvim_create_augroup('highlightYank', { clear = true })
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = highlight_yank,
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 200 }
  end,
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

local function get_background()
  local background = 'light'

  if vim.fn.getenv 'DARKMODE' == '1' then
    background = 'dark'
  end

  return background
end

vim.o.background = get_background()
