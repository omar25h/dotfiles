local M = {}

function M.setup()
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

  telescope = require 'telescope.builtin'

  vim.keymap.set('n', '<Leader>ff', telescope.find_files, { desc = 'Find files' })
  vim.keymap.set(
    'n',
    '<Leader>fg',
    require('telescope').extensions.live_grep_args.live_grep_args,
    { desc = 'Live grep files' }
  )
  vim.keymap.set('n', '<Leader>fb', telescope.buffers, { desc = 'List buffers' })
  vim.keymap.set('n', '<Leader>fh', telescope.help_tags, { desc = 'List help tags' })
end
return M
