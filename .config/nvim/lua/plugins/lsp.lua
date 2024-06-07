return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "html",
          "cssls",
          "gopls",
          "rust_analyzer",
          "tsserver",
          "tailwindcss",
          "eslint",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("core.lsp").defaults()
      require("configs.lsp-config")
    end,
  },
}
