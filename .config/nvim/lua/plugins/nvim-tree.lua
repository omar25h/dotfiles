return {
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require 'configs.nvim-tree' end,
  },
}
