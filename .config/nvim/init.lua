local nvim_lsp = require'nvim_lsp'
local completion = require'completion'

local root_pattern = nvim_lsp.util.root_pattern

-------------------------------------------------------------------------------------------------
-- Rust
-------------------------------------------------------------------------------------------------

nvim_lsp.rust_analyzer.setup{
    on_attach = completion.on_attach
}

-------------------------------------------------------------------------------------------------
-- C/C++/Objective-C
-------------------------------------------------------------------------------------------------

nvim_lsp.ccls.setup{
    on_attach = completion.on_attach
}

-------------------------------------------------------------------------------------------------
-- Golang
-------------------------------------------------------------------------------------------------

nvim_lsp.gopls.setup{
    on_attach = completion.on_attach
}

-------------------------------------------------------------------------------------------------
-- JavaScript/TypeScript
-------------------------------------------------------------------------------------------------

nvim_lsp.tsserver.setup{
    on_attach = completion.on_attach
}

-------------------------------------------------------------------------------------------------
-- JSON
-------------------------------------------------------------------------------------------------

nvim_lsp.jsonls.setup{
    on_attach = completion.on_attach
}

-------------------------------------------------------------------------------------------------
-- Scala
-------------------------------------------------------------------------------------------------

nvim_lsp.metals.setup{
    on_attach = completion.on_attach
}

-------------------------------------------------------------------------------------------------
-- LaTex
-------------------------------------------------------------------------------------------------

nvim_lsp.texlab.setup{
    on_attach = completion.on_attach
}

