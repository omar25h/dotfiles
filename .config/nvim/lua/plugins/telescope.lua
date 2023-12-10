return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = [[cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \z
          cmake --build build --config Release && cmake --install build --prefix build \z]],
      },
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
    keys = {
      { '<Leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
      {
        '<Leader>fg',
        function() require('telescope').extensions.live_grep_args.live_grep_args() end,
        desc = 'Live grep files',
      },
      { '<Leader>fb', function() require('telescope.builtin').buffers() end, desc = 'List buffers' },
      { '<Leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'List help tags' },
      {
        '<Leader>dd',
        function() require('telescope.builtin').diagnostics() end,
        noremap = true,
        silent = true,
        desc = 'List diagnostics',
      },
    },
    opts = {
      pickers = {
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          mappings = {
            i = { ['<c-d>'] = 'delete_buffer' },
            n = { ['d'] = 'delete_buffer' },
          },
        },
        find_files = { hidden = true },
        live_grep = { additional_args = function() return { '--hidden', '--glob=!.git/' } end },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    },
    config = function(_, opts)
      local ts = require 'telescope'

      ts.load_extension 'fzf'
      ts.load_extension 'live_grep_args'

      ts.setup(opts)
    end,
  },
}
