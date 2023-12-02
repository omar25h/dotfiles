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
    event = 'InsertEnter',
    config = function() require('nvim-autopairs').setup {} end,
  },
  {
    'kylechui/nvim-surround',
    event = 'BufEnter',
    config = function() require('nvim-surround').setup {} end,
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
  keys = {
    { 'zR', function() require('ufo').openAllFolds() end },
    { 'zM', function() require('ufo').closeAllFolds() end },
    {
      'K',
      function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then vim.lsp.buf.hover() end
      end,
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'BufRead',
    opts = function(_, opts)
      vim.o.foldcolumn = '0'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      opts.fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
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
      end

      opts.provider_selector = function() return { 'treesitter', 'indent' } end
    end,
  },
}
