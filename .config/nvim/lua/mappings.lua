require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map({ "n" }, "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map({ "n" }, "<leader>dus", function()
  local widgets = require("dap.ui.widgets");
  local sidebar = widgets.sidebar(widgets.scopes);
  sidebar.open();
end, { desc = "Open debugging sidebar" })

map({ "n" }, "<leader>dgt", function()
  require("dap-go").debug_test()
end, { desc = "Debug go test" })
map({ "n" }, "<leader>dgl", function ()
  require("dap-go").debug_last()
end, { desc = "Debug last go test" })

map({ "n" }, "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Window left" })
map({ "n" }, "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Window right" })
map({ "n" }, "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Window down" })
map({ "n" }, "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Window up" })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- enable omnifunc completion
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- buffer local mappings
    map({ "n" }, "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
    map({ "n" }, "K", vim.lsp.buf.hover, { buffer = ev.buf })
  end
})
