---@diagnostic disable: undefined-global
local caser = require 'oh.caser.util'

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
  s({ trig = 'tjs', name = 'JSON field tag' }, {
    t '`json:"',
    d(1, function()
      local text = 'name'
      local node = vim.treesitter.get_node()
      if node and node:type() == 'field_declaration' then
        node = node:child(0)
        text = caser.convert_to_snake_case(vim.treesitter.get_node_text(node, 0))
      end
      return s('', {
        i(1, text),
      })
    end),
    c(2, { t '', t ',omitempty' }),
    t '"`',
    i(0),
  }),
}
