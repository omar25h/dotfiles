return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = { '<Leader>ff', '<Leader>fg', '<Leader>fh', '<Leader>fb' },
    dependencies = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
    config = function() require('oh.telescope').setup() end,
  },
}
