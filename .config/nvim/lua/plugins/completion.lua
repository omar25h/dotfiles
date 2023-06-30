return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'onsails/lspkind-nvim',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function() require 'oh.completion' end,
  },
}
