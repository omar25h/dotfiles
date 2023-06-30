return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/neodev.nvim',
        config = function() require('neodev').setup {} end,
      },
    },
    config = function() require 'oh.lsp' end,
  },
  'b0o/schemastore.nvim',
}
