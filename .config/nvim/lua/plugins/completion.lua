return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'onsails/lspkind-nvim',
      'saadparwaiz1/cmp_luasnip',
    },
    event = 'InsertEnter',
    config = function() require('oh.completion').setup() end,
  },
}
