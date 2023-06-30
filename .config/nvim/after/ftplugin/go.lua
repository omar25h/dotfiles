vim.bo.expandtab = false
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4

-- Example gomodifytags usage:
--
-- gomodifytags -file model/address.go -all -clear-options -clear-tags -add-tags json -transform snakecase -w
--
vim.api.nvim_buf_create_user_command(0, 'GoAddTags', function(cmd)
  local file_name = vim.fn.expand '%'
  local output = vim.fn.systemlist('gomodifytags -all -file ' .. file_name .. ' -add-tags ' .. cmd.args, nil, 0)
  if output[#output] == '' then table.remove(output, #output) end
  vim.api.nvim_buf_set_lines(0, 0, -1, true, output)
end, {
  nargs = '+',
})

vim.api.nvim_buf_create_user_command(0, 'GoRemoveTags', function(cmd)
  local file_name = vim.fn.expand '%'
  local output = vim.fn.systemlist('gomodifytags -all -file ' .. file_name .. ' -remove-tags ' .. cmd.args, nil, 0)
  if output[#output] == '' then table.remove(output, #output) end
  vim.api.nvim_buf_set_lines(0, 0, -1, true, output)
end, {
  nargs = '+',
})

vim.api.nvim_buf_create_user_command(0, 'GoClearTags', function()
  local file_name = vim.fn.expand '%'
  local updated = vim.fn.systemlist('gomodifytags -all -file ' .. file_name .. ' -clear-tags ', nil, 0)
  if updated[#updated] == '' then table.remove(updated, #updated) end
  vim.api.nvim_buf_set_lines(0, 0, -1, true, updated)
end, {
  nargs = 0,
})

vim.api.nvim_buf_create_user_command(0, 'GoModifyTags', function(cmd)
  local file_name = vim.fn.expand '%'
  local updated = vim.fn.systemlist('gomodifytags -all -file ' .. file_name .. ' ' .. cmd.args, nil, 0)
  if updated[#updated] == '' then table.remove(updated, #updated) end
  vim.api.nvim_buf_set_lines(0, 0, -1, true, updated)
end, {
  nargs = '*',
})

local go_group = vim.api.nvim_create_augroup('Go', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = go_group,
  pattern = { '*.go' },
  callback = function() vim.lsp.buf.format { timeout_ms = 5000 } end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = go_group,
  pattern = { '*.go' },
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(0))
    params.context = { only = { 'source.organizeImports' } }

    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 7000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(0))
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})
