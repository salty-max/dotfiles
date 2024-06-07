return {
  "akinsho/bufferline.nvim",
  tag = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        close_command = "bnext | bdelete #",
        left_mouse_command = "buffer %d",
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
      },
    })
  end,
}
