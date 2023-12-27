return {
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    opts = {
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
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'kylechui/nvim-surround',
    event = 'BufEnter',
    config = true,
  },
  {
    'rebelot/heirline.nvim',
    event = 'UIEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function() require('oh.statusline').setup() end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
  },
  {
    'NoahTheDuke/vim-just',
    event = { 'BufReadPre', 'BufNewFile' },
    ft = { '\\cjustfile', '*.just', '.justfile' },
  },
}
