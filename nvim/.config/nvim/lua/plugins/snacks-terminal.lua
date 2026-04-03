return {
  {
    "folke/snacks.nvim",
    init = function()
      vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
        callback = function()
          if vim.bo.filetype == "snacks_terminal" then
            vim.cmd("startinsert")
          end
        end,
      })
    end,
  },
}
