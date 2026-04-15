return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("everforest").setup({
				background = "medium",
				variant = "black",
			})
			vim.o.background = "dark"
			vim.cmd("colorscheme everforest")
		end,
	},
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme catppuccin-mocha")
	-- 	end,
	-- },
}
