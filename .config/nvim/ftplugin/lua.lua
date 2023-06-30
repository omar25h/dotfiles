local lua_group = vim.api.nvim_create_augroup('Lua', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = '*.lua',
  group = lua_group,
  callback = function() require('oh.stylua').format() end,
})
