require('telescope').setup {
  pickers = {
    find_files = {
      hidden = true,
      -- find_command = { 'rg', '--hidden'},
    },
    live_grep = {
      additional_args = function()
        return { '--hidden', '--glob=!.git/' }
      end,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

require('telescope').load_extension 'fzf'
require('telescope').load_extension 'live_grep_args'
