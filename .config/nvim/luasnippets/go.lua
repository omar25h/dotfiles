---@diagnostic disable: undefined-global

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
    i(1, 'name'),
    c(2, { t ',omitempty', t '' }),
    t '"`',
    i(0),
  }),
}
