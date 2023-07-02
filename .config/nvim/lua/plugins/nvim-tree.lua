return {
  {
    'kyazdani42/nvim-tree.lua',
    event = 'UIEnter',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require 'oh.nvim-tree' end,
  },
}
