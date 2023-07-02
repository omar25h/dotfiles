return {
  {
    'neovim/nvim-lspconfig',
    event = 'UIEnter',
    priority = 0,
    dependencies = {
      {
        'folke/neodev.nvim',
        config = function() require('neodev').setup {} end,
      },
    },
    config = function() require('oh.lsp').setup {} end,
  },
  'b0o/schemastore.nvim',
}
