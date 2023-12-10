return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    keys = '<Leader>ne',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('oh.nvim-tree').setup() end,
  },
}
