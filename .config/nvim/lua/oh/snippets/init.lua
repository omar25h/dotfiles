-------------------------------------------------------------------------------------------------
-- LuaSnip
-------------------------------------------------------------------------------------------------

local M = {}

local ls = require 'luasnip'
local types = require 'luasnip.util.types'

function M.setup()
  ls.config.set_config {
    history = true,
    update_events = 'TextChanged,TextChangedI',
    region_check_events = 'CursorMoved,InsertEnter',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '', 'GruvboxOrange' } },
        },
      },
    },
    ext_base_prio = 300,
    ext_prio_increase = 1,
  }

  M.reload_snippets()

  vim.keymap.set({ 's', 'i' }, '<c-l>', function()
    if ls.choice_active() then ls.change_choice(1) end
  end, { desc = 'Scroll through choice nodes' })

  vim.keymap.set({ 's', 'i' }, '<c-k>', function()
    if ls.expand_or_jumpable() then ls.expand_or_jump() end
  end, { desc = 'Expand or jump snippet' })

  vim.keymap.set({ 's', 'i' }, '<c-s>', function()
    if ls.jumpable(-1) then ls.jump(-1) end
  end, { desc = 'Jump backwards snippet' })
end

function M.reload_snippets()
  ls.cleanup()
  require('luasnip.loaders.from_lua').lazy_load()
end

return M
