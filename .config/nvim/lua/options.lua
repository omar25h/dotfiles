-------------------------------------------------------------------------------------------------
-- General Configuration
-------------------------------------------------------------------------------------------------

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

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes:1'

vim.cmd([[syntax on]])
if vim.wo.diff then
  vim.cmd([[syntax off]])
end
vim.cmd([[set laststatus=3]])

vim.g.mapleader = ','
vim.g.filetype_m = 'objc'
vim.g.tex_flavor = 'latex'

local highlight_yank = vim.api.nvim_create_augroup('highlightYank', { clear = true })
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = highlight_yank,
  callback = function() vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 }) end,
})

-------------------------------------------------------------------------------------------------
-- Styling
-------------------------------------------------------------------------------------------------

vim.api.nvim_exec([==[
colorscheme gruvbox
autocmd Filetype NvimTree,Help set signcolumn=no
autocmd Filetype tex setl filetype=tex
autocmd Filetype * set expandtab shiftwidth=2 tabstop=2
]==], false)

if vim.fn.getenv('DARKMODE') == '1' then
  vim.api.nvim_exec([[set background=dark]], false)
else
  vim.api.nvim_exec([[set background=light]], false)
end

