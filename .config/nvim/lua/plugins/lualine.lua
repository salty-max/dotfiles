return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
  config = function()
    require("lualine").setup({
      options = {
        theme = 'catppuccin',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { { 'mode', separator = { right = '' }, color = nil, right_padding = 2 } },
        lualine_b = {
          { 'filename', draw_empty = false },
          { 'branch', draw_empty = false },
          { 'diff', draw_empty = false },  
        },
        lualine_c = {
          '%=', --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = { 'diagnostics' },
        lualine_y = { 'filetype' },
        lualine_z = {
          'progress',
          'location',
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }) 
  end
}
