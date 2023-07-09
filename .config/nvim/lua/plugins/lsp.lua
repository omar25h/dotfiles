return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'folke/neodev.nvim',
        config = function() require('neodev').setup {} end,
      },
    },
    config = function() require('oh.lsp').setup() end,
  },
  {
    'b0o/schemastore.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    ft = { 'json', 'lua' },
  },
}
