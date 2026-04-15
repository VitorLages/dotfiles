return {
	"kndndrj/nvim-dbee",
	dependencies = { "MunifTanjim/nui.nvim" },
	build = function()
		require("dbee").install()
	end,
	config = function()
		require("dbee").setup({
			sources = {
				require("dbee.sources").MemorySource:new({
					{
						name = "banco",
						type = "postgres",
						url = "http://127.0.0.1:5432/",
						-- name = "exportador",
						-- type = "sqlite",
						-- url = "~/Documents/Workspace/ES25-C012_extrator-esse-copasa/my.db",
					},
				}),
				require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
				require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
			},
		})
		vim.keymap.set("n", "<leader>db", function()
			require("dbee").open()
		end, { noremap = true })
	end,
}
