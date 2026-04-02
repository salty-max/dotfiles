return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<leader>fy", "<cmd>Yazi<cr>", desc = "Yazi (current file)" },
      { "<leader>fY", "<cmd>Yazi cwd<cr>", desc = "Yazi (cwd)" },
    },
    opts = {
      open_for_directories = true,
    },
  },
}
