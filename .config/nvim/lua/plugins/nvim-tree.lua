return {
  {
    'kyazdani42/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    keys = '<Leader>ne',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require('oh.nvim-tree').setup() end,
  },
}
