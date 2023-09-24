-------------------------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------------------------

local lspconfig = require 'lspconfig'
local cmplsp = require 'cmp_nvim_lsp'

local capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

---@return string[]
local function get_lua_workspace_files()
  local paths = {}
  for _, f in ipairs(vim.api.nvim_get_runtime_file('', true)) do
    paths[#paths + 1] = f:gsub('/lazy/([^/]+)$', '/lazy/%1/lua')
    if f:match '/lazy/neodev.nvim' then
      local version = not vim.version().prerelease and 'stable' or 'nightly'
      paths[#paths + 1] = f:gsub('/lazy/([^/]+)$', '/lazy/%1/types/' .. version)
    end
  end

  return paths
end

local M = {}

function M.setup()
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

  -- Get the value of the module name from go.mod in PWD
  local function get_go_module_name()
    if vim.fn.filereadable 'go.mod' == 0 then return nil end
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
        ['ui.completion.usePlaceholders'] = true,
        ['ui.completion.experimentalPostfixCompletions'] = true,
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
        runtime = {
          version = 'LuaJIT',
        },
        workspace = {
          library = get_lua_workspace_files(),
          checkThirdParty = false,
        },
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
end

return M
