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
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'BufRead',
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
      { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
      {
        'K',
        function()
          local winid = require('ufo').peekFoldedLinesUnderCursor()
          if not winid then vim.lsp.buf.hover() end
        end,
        desc = 'Peek Folded Lines or Hover',
      },
    },
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
