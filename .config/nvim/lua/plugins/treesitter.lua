return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			ensure_installed = { "lua", "luadoc", "javascript", "typescript", "tsx", "go", "printf", "vim", "vimdoc" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
