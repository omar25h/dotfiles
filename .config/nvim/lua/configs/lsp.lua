-------------------------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------------------------

local lspconfig = require 'lspconfig'
local cmplsp = require 'cmp_nvim_lsp'

local capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Rust
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
}

-- C/C++/Objective-C
lspconfig.ccls.setup {
  capabilities = capabilities,
}

-- Golang

-- see if the file exists
function FileExists(file)
  local f = io.open(file, 'rb')
  if f then
    f:close()
  end
  return f ~= nil
end

-- Get the value of the module name from go.mod in PWD
function GetGoModuleName()
  if not FileExists 'go.mod' then
    return nil
  end
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
      ['local'] = GetGoModuleName(),
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.go' },
  callback = function()
    vim.lsp.buf.format { timeout_ms = 5000 }
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
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
