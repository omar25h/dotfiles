-------------------------------------------------------------------------------------------------
-- Treesitter
-------------------------------------------------------------------------------------------------

require'nvim-treesitter.install'.compilers = { 'gcc' }

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = 'https://github.com/vhyrro/tree-sitter-norg',
        files = { 'src/parser.c', 'src/scanner.cc' },
        branch = 'main'
    },
}

parser_configs.just = {
  install_info = {
    url = 'https://github.com/IndianBoy42/tree-sitter-just',
    files = { 'src/parser.c', 'src/scanner.cc' },
    branch = 'main',
    revision = '8af0aab79854aaf25b620a52c39485849922f766',
  },
  maintainers = { '@IndianBoy42' },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = 'all',
  highlight = {
    enable = true,
  },
}

