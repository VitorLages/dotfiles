return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				enabled = true,
			},
		},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					layout_config = { prompt_position = "top" },
					sorting_strategy = "ascending",
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
						},
					},
				},
			})

			local builtin = require("telescope.builtin")
			-- Search help.
			vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
			-- Search files.
			vim.keymap.set("n", "<leader>/", builtin.find_files, {})
			-- Search by grep.
			vim.keymap.set("n", "<leader>?", builtin.live_grep, {})
			-- Search diagnostics.
			vim.keymap.set("n", "<leader>d", builtin.diagnostics, {})
			-- Fuzzily seach in current buffer.
			vim.keymap.set("n", "<leader><leader>", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, {})
		end,
	},
}
