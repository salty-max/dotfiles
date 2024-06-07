local M = {}
local map = vim.keymap.set

-- Export on_attach & capabilities
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "K", vim.lsp.buf.hover, opts("Hover information"))
  map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
  map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
  map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
  map("n", "gr", vim.lsp.buf.references, opts("Show references"))
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Show code actions"))

  map("n", "<leader>gf", vim.lsp.buf.format, opts("Format buffer"))
end

M.on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  require("lspconfig").lua_ls.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
          },
          mapPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })
end

return M
