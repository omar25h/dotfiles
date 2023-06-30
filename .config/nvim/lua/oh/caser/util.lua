local M = {}

M.convert_to_snake_case = function(word) return word:gsub('([a-z])([A-Z])', '%1_%2'):lower() end

M.convert_to_camel_case = function(word)
  word = word:gsub('^%l', string.lower)

  return word:gsub('(_)([a-z])', function(_, l) return l:upper() end)
end

M.convert_to_pascal_case = function(word)
  word = word:gsub('^%l', string.upper)

  return word:gsub('(_)([a-z])', function(_, l) return l:upper() end)
end

return M
