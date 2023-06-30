local telescope = require 'telescope'

telescope.setup {
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ['<c-d>'] = 'delete_buffer',
        },
        n = {
          ['d'] = 'delete_buffer',
        },
      },
    },
    find_files = {
      hidden = true,
    },
    live_grep = {
      additional_args = function() return { '--hidden', '--glob=!.git/' } end,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
}

telescope.load_extension 'fzf'
telescope.load_extension 'live_grep_args'
