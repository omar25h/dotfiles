return {
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    build = 'make install_jsregexp',
    config = function() require('oh.snippets').setup() end,
  },
}
