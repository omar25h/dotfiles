return {
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    build = 'make install_jsregexp',
    keys = {
      {
        '<c-l>',
        function()
          local ls = require 'luasnip'
          if ls.choice_active() then ls.change_choice(1) end
        end,
        mode = { 's', 'i' },
        { desc = 'Scroll through choice nodes' },
      },
      {
        '<c-k>',
        function()
          local ls = require 'luasnip'
          if ls.expand_or_jumpable() then ls.expand_or_jump() end
        end,
        mode = { 's', 'i' },
        { desc = 'Scroll through choice nodes' },
      },
      {
        '<c-s>',
        function()
          local ls = require 'luasnip'
          if ls.jumpable(-1) then ls.jump(-1) end
        end,
        mode = { 's', 'i' },
        { desc = 'Jump backwards snippet' },
      },
      {
        '<Leader><Leader>s',
        function()
          require('luasnip').cleanup()
          require('luasnip.loaders.from_lua').lazy_load()
        end,
        { desc = 'Reload snippets' },
      },
    },
    config = function()
      local types = require 'luasnip.util.types'

      require('luasnip').config.set_config {
        history = true,
        update_events = { 'TextChanged', 'TextChangedI' },
        region_check_events = { 'CursorMoved', 'InsertEnter' },
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { '', 'Special' } },
            },
          },
        },
        ext_base_prio = 300,
        ext_prio_increase = 1,
      }

      require('luasnip.loaders.from_lua').lazy_load()
    end,
  },
}
