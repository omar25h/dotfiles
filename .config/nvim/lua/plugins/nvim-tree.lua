return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        '<Leader>ne',
        function() require('nvim-tree.api').tree.toggle { find_file = true, focus = true } end,
        { desc = 'Toggle nvim-tree' },
      },
    },
    opts = {
      view = {
        float = {
          enable = true,
          open_win_config = function()
            local height_ratio = 0.8
            local width_ratio = 0.5

            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * width_ratio
            local window_h = screen_h * height_ratio
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
      },
    },
    config = function(_, opts)
      require('nvim-tree').setup(opts)

      local api = require 'nvim-tree.api'
      local Event = api.events.Event

      api.events.subscribe(Event.TreeOpen, function()
        vim.opt.signcolumn = 'no'
        vim.opt.fillchars = {}
      end)
    end,
  },
}
