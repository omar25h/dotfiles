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
    init = function()
      local ts = require 'telescope'

      ts.load_extension 'fzf'
      ts.load_extension 'live_grep_args'
    end,
    keys = function()
      local ext = require('telescope').extensions
      local ts = require 'telescope.builtin'

      return {
        { '<Leader>ff', ts.find_files, desc = 'Find files' },
        { '<Leader>fg', ext.live_grep_args.live_grep_args, desc = 'Live grep files' },
        { '<Leader>fb', ts.buffers, desc = 'List buffers' },
        { '<Leader>fh', ts.help_tags, desc = 'List help tags' },
        { '<Leader>dd', ts.diagnostics, noremap = true, silent = true, desc = 'List diagnostics' },
      }
    end,
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
  },
}
