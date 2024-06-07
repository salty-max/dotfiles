local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move end of line" })

map("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
map("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
map("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
map("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General clear highlights" })

map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "File copy whole" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

map("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Move to next buffer" })
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Move to previous buffer" })
map("n", "<leader>x", "<cmd>bnext | bdelete #<CR>", { desc = "Close current buffer" })

map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle current line blame" })

map("n", "<leader>tn", ":TestNearest<CR>", { desc = "Test nearest" })
map("n", "<leader>tf", ":TestFile<CR>", { desc = "Test file" })
map("n", "<leader>ts", ":TestSuite<CR>", { desc = "Test suite" })
map("n", "<leader>tl", ":TestLast<CR>", { desc = "Test last" })
map("n", "<leader>tv", ":TestVisit<CR>", { desc = "Test visit" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		map("n", "K", vim.lsp.buf.hover, { desc = "Hover information" })
		map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
		map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
		map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })

		map("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format buffer" })
	end,
})
