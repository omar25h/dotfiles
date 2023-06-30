-------------------------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------------------------

local lspconfig = require 'lspconfig'
local cmplsp = require 'cmp_nvim_lsp'

local capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Rust
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      inlayHints = {},
    },
  },
}

-- C/C++/Objective-C
lspconfig.clangd.setup {
  capabilities = capabilities,
}

-- Golang

-- check whether the file exists
-- TODO: move to a common module
function file_exists(file)
  local f = io.open(file, 'rb')
  if f then f:close() end
  return f ~= nil
end

-- Get the value of the module name from go.mod in PWD
function get_go_module_name()
  if not file_exists 'go.mod' then return nil end
  for line in io.lines 'go.mod' do
    if vim.startswith(line, 'module') then
      local items = vim.split(line, ' ')
      local module_name = vim.trim(items[2])
      return module_name
    end
  end
  return nil
end

lspconfig.gopls.setup {
  capabilities = capabilities,
  settings = {
    gopls = {
      ['local'] = get_go_module_name(),
      analyses = {
        unusedparams = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      staticcheck = true,
    },
  },
}

-- JavaScript/TypeScript
lspconfig.tsserver.setup {
  capabilities = capabilities,
}

-- Vue
lspconfig.vuels.setup {
  capabilities = capabilities,
}

-- JSON
lspconfig.jsonls.setup {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

-- Lua
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- LaTex
lspconfig.texlab.setup {
  capabilities = capabilities,
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
lspconfig.terraformls.setup {}
