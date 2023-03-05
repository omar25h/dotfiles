return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require 'configs.lualine'
    end,
  },
}
