local M = {}

local util = require 'oh.caser.util'

function M.switch_case()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand '<cword>' --[[@as string]]
  local word_start = vim.fn.matchstrpos(vim.fn.getline '.', '\\k*\\%' .. (col + 1) .. 'c\\k*')[2]

  if word:find '[a-z][A-Z]' then
    local snake_case_word = word:gsub('([a-z])([A-Z])', '%1_%2'):lower()
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
  elseif word:find '_[a-z]' then
    local camel_case_word = word:gsub('(_)([a-z])', function(_, l) return l:upper() end)
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { camel_case_word })
  else
    vim.notify('Not a snake_case or camelCase word', vim.log.levels.WARN)
  end
end

function M.to_snake_case()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand '<cword>' --[[@as string]]
  local word_start = vim.fn.matchstrpos(vim.fn.getline '.', '\\k*\\%' .. (col + 1) .. 'c\\k*')[2]

  if word:find '[a-z][A-Z]' then
    vim.api.nvim_buf_set_text(
      0,
      line - 1,
      word_start,
      line - 1,
      word_start + #word,
      { util.convert_to_snake_case(word) }
    )
  end
end

function M.to_camel_case()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand '<cword>' --[[@as string]]
  local word_start = vim.fn.matchstrpos(vim.fn.getline '.', '\\k*\\%' .. (col + 1) .. 'c\\k*')[2]

  vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { util.convert_to_camel_case(word) })
end

function M.to_pascal_case()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand '<cword>' --[[@as string]]
  local word_start = vim.fn.matchstrpos(vim.fn.getline '.', '\\k*\\%' .. (col + 1) .. 'c\\k*')[2]

  local pascal_case_word = util.convert_to_pascal_case(word)

  if pascal_case_word ~= word then
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { pascal_case_word })
  end
end

return M
