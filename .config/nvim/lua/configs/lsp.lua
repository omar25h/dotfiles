-------------------------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------------------------

local lspconfig = require'lspconfig'
local cmplsp = require'cmp_nvim_lsp'

-- Rust
lspconfig.rust_analyzer.setup{
  capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- C/C++/Objective-C
lspconfig.ccls.setup{
  capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Golang

-- see if the file exists
function FileExists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- Get the value of the module name from go.mod in PWD
function GetGoModuleName()
  if not FileExists("go.mod") then return nil end
  for line in io.lines("go.mod") do
    if vim.startswith(line, "module") then
      local items = vim.split(line, " ")
      local module_name = vim.trim(items[2])
      return module_name
    end
  end
  return nil
end

lspconfig.gopls.setup{
  capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    gopls = {
      ['local'] = GetGoModuleName(),
    },
  }
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
	  vim.lsp.buf.format(nil, 5000)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
		params.context = {only = {"source.organizeImports"}}

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 7000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})

-- JavaScript/TypeScript
lspconfig.tsserver.setup{
  capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Vue
lspconfig.vuels.setup{
  capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- JSON
lspconfig.jsonls.setup{
  capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

-- Lua
local sumneko_root_path = os.getenv('LUA_LSP')
local sumneko_binary = sumneko_root_path.."/bin/lua-language-server"
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
  capabilities = cmplsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
