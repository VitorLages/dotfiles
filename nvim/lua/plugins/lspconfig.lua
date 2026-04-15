return { -- LSP Configuration & Plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		},
		config = function()
			-- Configures the current buffer when a file associated with an lsp is opened,.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					-- Defines mappings specific for LSP related items.
					local map = function(keys, func)
						vim.keymap.set("n", keys, func, {})
					end

					-- Jump to definition.
					map("gd", require("telescope.builtin").lsp_definitions)
					-- Find references.
					map("gr", require("telescope.builtin").lsp_references)
					-- Jump to implementation.
					map("gI", require("telescope.builtin").lsp_implementations)
					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols)

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)
					-- Rename variable.
					map("<leader>rn", vim.lsp.buf.rename)
					-- Execute a code action.
					map("<leader>ca", vim.lsp.buf.code_action)
					-- Display documentation.
					map("K", vim.lsp.buf.hover)
					-- Jump to declaration.
					map("gD", vim.lsp.buf.declaration)

					-- Inlay hint stuff
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>ih", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end)
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- Enable the following language servers
			local servers = {
				-- clangd = {},
				-- gopls = {},
				vue_ls = {
					filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
					init_options = {
						vue = {
							hybridMode = false,
						},
						typescript = {
							tsdk = vim.fn.stdpath("data")
								.. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
						},
					},
				},
				ts_ls = {
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = vim.fn.stdpath("data")
									.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
								languages = { "vue" },
							},
						},
					},
				},
				pylsp = {
					settings = {
						pylsp = {
							plugins = {
								pycodestyle = {
									enabled = true,
									ignore = { "E302", "E501", "W293", "W291", "E202", "E226", "W292", "E501" },
									maxLineLength = 120,
								},
								pyflakes = { enabled = true },
								pylsp_mypy = { enabled = true },
								jedi_completion = {
									enabled = true,
								},
								rope_autoimport = { enabled = true },
							},
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = {
								disable = { "missing-fields" },
								globals = { "vim" },
							},
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"vue-language-server",
				"typescript-language-server",
				"python-lsp-server",
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server_opts = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server_opts.capabilities =
							vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})

						require("lspconfig")[server_name].setup(server_opts)
					end,
				},
			})
		end,
	},
}
