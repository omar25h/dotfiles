---@diagnostic disable: undefined-global

local function comment_parts()
  local commentstring = vim.bo.commentstring .. '%s'
  local parts = {}
  for w in commentstring:gmatch '(.-)%%s' do
    table.insert(parts, w)
  end
  return parts
end

local function create_special_comment(name)
  local parts = comment_parts()

  local nodes = {
    t(parts[1] .. name),
    c(1, {
      sn(1, { t '(', i(1, 'OH'), t ')' }),
      t '',
    }),
    t ': ',
    i(2),
  }

  if #parts == 2 then
    table.insert(nodes, t(parts[2]))
  end

  return nodes
end

return {
  s({ trig = 'fixme', name = 'FIXME' }, {
    d(1, function()
      return s('', create_special_comment 'FIXME')
    end),
  }),
  s({ trig = 'todo', name = 'TODO' }, {
    d(1, function()
      return s('', create_special_comment 'TODO')
    end),
  }),
  s({ trig = 'note', name = 'NOTE' }, {
    d(1, function()
      return s('', create_special_comment 'NOTE')
    end),
  }),
}, {}
