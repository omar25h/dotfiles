---@diagnostic disable: undefined-global
local caser = require 'oh.caser.util'

---comment
---@param node TSNode
---@param pos integer[]
---@return string
local get_tag_name = function(node, pos)
  local text = 'name'

  if not node or node:type() ~= 'field_declaration_list' then return text end

  -- Loop in reverse order and check for the first entry that
  -- starts before the current cursor position.
  for i = node:named_child_count() - 1, 0, -1 do
    local child_node = node:named_child(i)
    if child_node:type() == 'field_declaration' then
      local start_row, start_column, _, _ = child_node:range()

      if start_row <= pos[1] - 1 and start_column <= pos[2] then
        local field_name_node = child_node:named_child(0)
        text = vim.treesitter.get_node_text(field_name_node, 0)
        text = caser.convert_to_snake_case(text)
        return text
      end
    end
  end

  return text
end

return {
  s(
    { trig = 'fei', name = 'Call function with error return' },
    fmta(
      [[
        <val>, <err> := <call>
        if <same_err> != nil {
          <handle>
        }<ending>
      ]],
      {
        val = i(1, 'val'),
        err = i(2, 'err'),
        call = i(3, 'call'),
        same_err = rep(2),
        handle = i(4),
        ending = i(0),
      }
    )
  ),
  s(
    { trig = 'fn', name = 'Create a function' },
    fmta(
      [[
        func <name>(<args>)<return_type> {
            <body>
        }<cursor>
      ]],
      {
        name = i(1),
        args = i(2),
        return_type = c(3, {
          sn(1, { t ' (', i(1, 'string, error'), t ')' }),
          sn(1, { t ' ', i(1, 'error') }),
          t '',
        }),
        body = i(4),
        cursor = i(0),
      }
    )
  ),
  s({
    trig = 'tjs',
    name = 'JSON field tag',
    show_condition = function()
      local node = vim.treesitter.get_node()
      if not node then return false end

      while node and node:type() ~= 'struct_type' do
        node = node:parent()
      end

      if not node then return false end

      return true
    end,
  }, {
    t '`json:"',
    d(1, function()
      local node = vim.treesitter.get_node()
      while node and node:type() ~= 'field_declaration_list' do
        node = node:parent()
      end

      if not node then return s('', {
        i(1, text),
      }) end

      return s('', {
        i(1, get_tag_name(node, vim.api.nvim_win_get_cursor(0))),
      })
    end),
    c(2, { t '', t ',omitempty' }),
    t '"`',
    i(0),
  }),
}
