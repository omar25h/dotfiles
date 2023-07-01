local M = {}

---Get closest field name at cursor position
---@param node TSNode|nil
---@param pos integer[]
---@param fallback string
---@return string
M.get_field_name = function(node, pos, fallback)
  while node and node:type() ~= 'field_declaration_list' do
    node = node:parent()
  end

  if not node then return fallback end

  -- Loop in reverse order and check for the first entry that
  -- starts before the current cursor position.
  for i = node:named_child_count() - 1, 0, -1 do
    local child_node = node:named_child(i)
    if child_node:type() == 'field_declaration' then
      local start_row, start_column, _, _ = child_node:range()

      if start_row <= pos[1] - 1 and start_column <= pos[2] then
        local field_name_node = child_node:named_child(0)
        return vim.treesitter.get_node_text(field_name_node, 0)
      end
    end
  end

  return fallback
end

---Check whether node is in struct_type node
---@param node TSNode|nil
---@return boolean
M.is_in_struct_definition = function(node)
  while node and node:type() ~= 'struct_type' do
    node = node:parent()
  end

  return node ~= nil
end

return M
