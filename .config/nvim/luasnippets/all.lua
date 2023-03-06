---@diagnostic disable: undefined-global

local function with_cmt(cmt)
  return string.format(vim.bo.commentstring, cmt)
end

return {
  s({ trig = "fixme", name = "FIXME" }, {
    d(1, function()
      return s("", {
        f(function() return with_cmt("FIXME") end, {}),
        c(1, {
          sn(1, { t "(", i(1, "OH"), t ")" }),
          t "",
        }),
        t(": "),
        i(0),
      })
    end),
  }),
  s({ trig = "todo", name = "TODO" }, {
    d(1, function()
      return s("", {
        f(function() return with_cmt("TODO") end, {}),
        c(1, {
          sn(1, { t "(", i(1, "OH"), t ")" }),
          t "",
        }),
        t(": "),
        i(0),
      })
    end),
  }),
}, {}
