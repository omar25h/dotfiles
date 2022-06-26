-------------------------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------------------------

vim.lsp.set_log_level('TRACE')

 -- Setup nvim-cmp.
local cmp = require'cmp'
local types = require('cmp.types')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }
})


local lspconfig = require'lspconfig'
local cmplsp = require'cmp_nvim_lsp'

-- Rust
lspconfig.rust_analyzer.setup{
  capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- C/C++/Objective-C
lspconfig.ccls.setup{
  capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Golang
lspconfig.gopls.setup{
  capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- JavaScript/TypeScript
lspconfig.tsserver.setup{
  capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Vue
lspconfig.vuels.setup{
  capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- JSON
lspconfig.jsonls.setup{
  capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Kotlin
lspconfig.kotlin_language_server.setup{
  capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Scala
lspconfig.metals.setup{
  capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Lua
local sumneko_root_path = os.getenv('LUA_LSP')
local sumneko_binary = sumneko_root_path.."/bin/lua-language-server"
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- LaTex
lspconfig.texlab.setup{
  capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    texlab = {
      build = {
        args = {
          '-pdf',
          '-interaction=nonstopmode',
          '-synctex=1',
          '-output-directory=dist',
        },
        onSave = true,
      },
    },
  },
}

-- Terraform
lspconfig.terraformls.setup{}
