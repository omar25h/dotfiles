return {
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      require('gruvbox').setup {
        overrides = {
          CursorLineNr = { bg = '' },
          GruvboxAquaSign = { bg = '' },
          GruvboxBlueSign = { bg = '' },
          GruvboxGreenSign = { bg = '' },
          GruvboxOrangeSign = { bg = '' },
          GruvboxPurpleSign = { bg = '' },
          GruvboxRedSign = { bg = '' },
          GruvboxYellowSign = { bg = '' },
          SignColumn = { bg = '' },
        },
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup {}
    end,
  },
  {
    'rebelot/heirline.nvim',
    event = 'UiEnter',
    config = function()
      require 'oh.statusline'
    end,
  },
}
