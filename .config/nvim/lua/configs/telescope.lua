require('telescope').setup{
  pickers = {
    find_files = {
      hidden = true,
      -- find_command = { 'rg', '--hidden'},
    },
    live_grep = {
      additional_args = function()
        return { '--hidden', '--glob=!.git/' }
      end
    },
  },
}

