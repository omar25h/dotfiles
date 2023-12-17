-------------------------------------------------------------------------------------------------
-- General Configuration
-------------------------------------------------------------------------------------------------

vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.cmdheight = 0
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.fillchars = { eob = '·' }
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { nbsp = '␣', trail = '·', tab = '» ' }
vim.opt.mouse = 'nvi'
vim.opt.number = true
vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
vim.opt.path:append ',**'
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append { c = true, W = false }
vim.opt.showcmdloc = 'statusline'
vim.opt.showmode = false
vim.opt.signcolumn = 'yes:1'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.wildmenu = true

vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.g.filetype_m = 'objc'
vim.g.tex_flavor = 'latex'

vim.diagnostic.config {
  virtual_text = { prefix = '●' },
  severity_sort = true,
  float = { source = 'always' },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✖',
      [vim.diagnostic.severity.HINT] = '➤',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.WARN] = '',
    },
  },
}

local highlight_yank = vim.api.nvim_create_augroup('highlightYank', { clear = true })
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = highlight_yank,
  callback = function() vim.highlight.on_yank { higroup = 'Visual', timeout = 200 } end,
})

local mode_changed = vim.api.nvim_create_augroup('ModeChanged', { clear = true })
vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  group = mode_changed,
  callback = function()
    vim.schedule(function() vim.cmd 'redrawstatus' end)
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    local function hl_link(group, link) vim.api.nvim_set_hl(0, group, { link = link }) end
    hl_link('NvimTreeNormalFloat', 'GruvboxFg1')
    hl_link('NvimTreeWinSeparator', 'GruvboxFg1')
    hl_link('WhichKeyBorder', 'FloatBorder')
    hl_link('WhichKey', 'Function')
    hl_link('WhichKeyGroup', 'Keyword')
    hl_link('WhichKeySeparator', 'DiffAdd')
    hl_link('WhichKeyDesc', 'Identifier')
    hl_link('WhichKeyFloat', 'NormalFloat')
    hl_link('WhichKeyBorder', 'FloatBorder')
    hl_link('WhichKeyValue', 'Comment')
  end,
})

vim.cmd.colorscheme 'gruvbox'
vim.o.background = vim.fn.getenv 'DARKMODE' == '1' and 'dark' or 'light'
