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
			vim.keymap.set("n", "<leader>H", ":NvimTreeResize -12<CR>", {})
			vim.keymap.set("n", "<leader>L", ":NvimTreeResize +12<CR>", {})

			require("nvim-tree").setup({
				renderer = {
					highlight_git = true,
					highlight_modified = "all",
					icons = {
						show = {
							modified = true,
						},
					},
				},
				filters = {
					dotfiles = false,
				},
				git = {
					enable = false,
				},
				modified = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
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
