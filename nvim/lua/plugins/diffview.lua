return {
	"sindrets/diffview.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
		{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
	},
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true, -- highlight dentro da linha (recomendado)
			use_icons = true,
			view = {
				default = {
					layout = "diff2_horizontal",
				},
				merge_tool = {
					layout = "diff3_horizontal",
				},
			},
		})
	end,
}
