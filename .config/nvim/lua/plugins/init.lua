return {
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    init = function()
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
  {
    'NoahTheDuke/vim-just',
    event = { 'BufReadPre', 'BufNewFile' },
    ft = { '\\cjustfile', '*.just', '.justfile' },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'BufRead',
    init = function()
      vim.opt.foldcolumn = '0'
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true
    end,
    keys = function()
      local ufo = require 'ufo'

      return {
        { 'zR', ufo.openAllFolds },
        { 'zM', ufo.closeAllFolds },
        {
          'K',
          function()
            local winid = ufo.peekFoldedLinesUnderCursor()
            if not winid then vim.lsp.buf.hover() end
          end,
        },
      }
    end,
    opts = {
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end,

      provider_selector = function() return { 'treesitter', 'indent' } end,
    },
  },
}
