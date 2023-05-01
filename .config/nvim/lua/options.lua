-------------------------------------------------------------------------------------------------
-- General Configuration
-------------------------------------------------------------------------------------------------

vim.o.exrc = true
vim.o.autoread = true
vim.o.autowrite = true
vim.o.mouse = 'nvi'
vim.o.path = vim.o.path .. ',**'
vim.o.wildmenu = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.hlsearch = true
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.cursorlineopt = 'number'
vim.o.cursorline = true

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes:1'

vim.g.filetype_m = 'objc'
vim.g.tex_flavor = 'latex'

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
    vim.api.nvim_exec2('startinsert', { output = false })
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = 'no'
  end,
})

-------------------------------------------------------------------------------------------------
-- Styling
-------------------------------------------------------------------------------------------------

if vim.fn.getenv 'DARKMODE' == '1' then
  vim.api.nvim_exec2([[set background=dark]], { output = false })
else
  vim.api.nvim_exec2([[set background=light]], { output = false })
end

vim.api.nvim_exec2(
  [==[
colorscheme gruvbox
autocmd Filetype NvimTree,Help set signcolumn=no
autocmd Filetype tex setl filetype=tex
autocmd Filetype * set expandtab shiftwidth=2 tabstop=2
]==],
  { output = false }
)

vim.api.nvim_set_keymap(
  'n',
  '<Leader>s',
  '<cmd>lua require("oh.caser").switch_case()<CR>',
  { noremap = true, silent = true }
)
