---@diagnostic disable: undefined-global
local caser = require 'oh.caser.util'
local ts_util = require('oh.treesitter.util').go

return {
  s(
    { trig = 'iferr', name = 'Handle error' },
    fmta(
      [[
        if <err> != nil {
          <handle>
        }<cursor>
      ]],
      {
        err = i(1, 'err'),
        handle = d(2, function(args)
          -- Get current function parameter
          local node = vim.treesitter.get_node()
          while node and node:type() ~= 'function_declaration' do
            node = node:parent()
          end

          if not node then return s('', {
            i(1, 'return'),
          }) end

          local result_node = node:field('result')[1]

          if result_node:type() == 'type_identifier' then
            return s('', {
              t 'return ',
              i(1, args[1][1]),
            })
          elseif result_node:type() == 'parameter_list' then
            -- take each param and provide default value,
            -- except for the last one
            local nodes = { t 'return ' }
            for idx = 0, result_node:named_child_count() - 1, 1 do
              local node_text = vim.treesitter.get_node_text(result_node:named_child(idx), 0)
              if node_text == 'string' then
                table.insert(nodes, i(idx + 1, '""'))
              elseif node_text == 'error' then
                table.insert(nodes, i(idx + 1, args[1][1]))
              else
                table.insert(nodes, i(idx + 1, node_text))
              end
              if idx < result_node:named_child_count() - 1 then table.insert(nodes, t ', ') end
            end

            return s('', nodes)
          else
            return s('', { t 'return' })
          end
        end, { 1 }),
        cursor = i(0),
      }
    )
  ),
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
        return_type = d(3, function()
          return s('', {
            f(function(args)
              if args[1][1]:match '[^( ] [^ )]' or args[1][1]:match ',' then
                return ' ('
              elseif #args[1][1] > 0 then
                return ' '
              else
                return ''
              end
            end, { 1 }),
            i(1),
            f(function(args)
              if args[1][1]:match '[^( ] [^ )]' or args[1][1]:match ',' then
                return ')'
              else
                return ''
              end
            end, { 1 }),
          })
        end),
        body = i(4),
        cursor = i(0),
      }
    )
  ),
  s({
    trig = 'tjs',
    name = 'JSON field tag',
    show_condition = function() return ts_util.is_in_struct_definition(vim.treesitter.get_node()) end,
  }, {
    t '`json:"',
    d(1, function()
      local tag = ts_util.get_field_name(vim.treesitter.get_node(), vim.api.nvim_win_get_cursor(0), 'name')
      tag = caser.convert_to_snake_case(tag)
      if vim.g.snippets_go_tag_case == 'camel' then tag = caser.convert_to_camel_case(tag) end
      return s('', {
        i(1, tag),
      })
    end),
    i(2, ''),
    t '"`',
    i(0),
  }),
}
