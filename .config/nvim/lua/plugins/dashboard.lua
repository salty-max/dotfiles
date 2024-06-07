return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local db = require("dashboard")
    local pokemon = require("pokemon")
    pokemon.setup({
      number = "0039",
      size = "auto",
    })
    db.setup({
      theme = "doom",
      config = {
        header = pokemon.header(),
        center = {
          {
            icon = " ",
            desc = " New File",
            action = "DashboardNewFile",
            shortcut = "SPC o",
          },
          {
            icon = " ",
            desc = " Find Files",
            action = "Telescope find_files",
            shortcut = "SPC f",
          },
          {
            icon = " ",
            desc = " Configure Neovim",
            action = "edit ~/.config/nvim/init.lua",
            shortcut = "SPC v",
          },
          {
            icon = " ",
            desc = " Exit Neovim",
            action = "quit",
          },
        },
      },
    })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons", "ColaMint/pokemon.nvim" },
}
