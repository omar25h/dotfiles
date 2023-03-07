return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/neodev.nvim',
        config = function()
          require('neodev').setup {}
        end,
      },
    },
    config = function()
      require 'configs.lsp'
    end,
  },
  'b0o/schemastore.nvim',
}
