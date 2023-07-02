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
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end,
  },
  {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup {} end,
  },
  {
    'rebelot/heirline.nvim',
    event = 'UIEnter',
    config = function() require 'oh.statusline' end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
    end,
  },
}
