return {
  "akinsho/bufferline.nvim",
  tag = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({})
  end,
}
