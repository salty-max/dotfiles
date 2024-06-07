local on_attach = require("core.lsp").on_attach
local on_init = require("core.lsp").on_init
local capabilities = require("core.lsp").capabilities

local lspconfig = require("lspconfig")
-- local util = require("lspconfig/util")
local servers = { "html", "cssls", "tsserver", "tailwindcss", "eslint" }

for _, lsp in pairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		on_init = on_init,
		capabilities = capabilities,
	})
end
