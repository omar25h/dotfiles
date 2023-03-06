---@diagnostic disable: undefined-global

return {
  s({trig = "fei", name = "Call function with error"},
    fmta([[
<val>, <err> := <call>
if <same_err> != nil {
	<handle>
}<ending>
]], {
				val = i(1, "val"),
				err = i(2, "err"),
				call = i(3, "call"),
				same_err = rep(2),
				handle = i(4),
				ending = i(0),
			})
  )
}
