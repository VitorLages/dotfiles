return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" }, -- Syntax aware text-objects.
		},
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"javascript",
					"html",
					"markdown",
					"vue",
					"lua",
					"typst",
					"typescript",
					"python",
					"c",
					"php",
					"go",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
