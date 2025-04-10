return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			-- Nvim tree keymaps.
			vim.keymap.set("n", "<leader>t", ":NvimTreeFindFileToggle<CR>", {})

			require("nvim-tree").setup({
				filters = {
					dotfiles = false,
				},
				git = {
					enable = false,
				},
				view = {
					relativenumber = true,
					number = true,
					width = 32,
				},
			})
		end,
	},
}
