return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("nvim-dap-virtual-text").setup()
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			dap.adapters.php = {
				type = "executable",
				command = "node",
				args = { "/home/valbuquerque/.local/share/vscode-php-debug/out/phpDebug.js" },
			}

			dap.configurations.php = {
				{
					type = "php",
					request = "launch",
					name = "Listen for Xdebug",
					port = 9003,
					stopOnEntry = false,
				},
			}

			-- Python configuration
			local dap_python = require("dap-python")

			-- Função para detectar o Python correto
			local function get_python_path()
				local venv_path = os.getenv("VIRTUAL_ENV")
				if venv_path then
					return venv_path .. "/bin/python"
				end

				-- Fallback para python no PATH
				return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or vim.fn.exepath("python")
			end

			-- Configure o dap-python com o Python correto
			dap_python.setup(get_python_path())

			-- Não sobrescreva as configurações, apenas adicione se necessário
			-- O dap-python.setup() já cria configurações adequadas

			-- Se você quiser uma configuração customizada, faça assim:
			dap.configurations.python = {
				-- Sua configuração original (melhorada)
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = function()
						local venv_path = os.getenv("VIRTUAL_ENV")
						if venv_path then
							return venv_path .. "/bin/python"
						else
							return "python3"
						end
					end,
					console = "integratedTerminal",
					cwd = "${workspaceFolder}",
				},

				-- Configuração adicional com argumentos
				{
					type = "python",
					request = "launch",
					name = "Launch file with arguments",
					program = "${file}",
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.split(args_string, " +", true)
					end,
					pythonPath = function()
						local venv_path = os.getenv("VIRTUAL_ENV")
						if venv_path then
							return venv_path .. "/bin/python"
						else
							return "python3"
						end
					end,
					console = "integratedTerminal",
					cwd = "${workspaceFolder}",
				},

				-- NOVA: Attach to Docker Container (porta fixa)
				{
					type = "python",
					request = "attach",
					name = "Attach to Docker (5678)",
					connect = {
						host = "localhost",
						port = 5678,
					},
					pathMappings = {
						{
							localRoot = vim.fn.getcwd(),
							remoteRoot = "/app",
						},
					},
					justMyCode = false,
				},

				-- NOVA: Attach to Docker Container (customizável)
				{
					type = "python",
					request = "attach",
					name = "Attach to Docker (Custom)",
					connect = function()
						local host = vim.fn.input("Host [localhost]: ", "localhost")
						local port = tonumber(vim.fn.input("Port [5678]: ", "5678"))
						return {
							host = host,
							port = port,
						}
					end,
					pathMappings = function()
						local local_root = vim.fn.input("Local root [" .. vim.fn.getcwd() .. "]: ", vim.fn.getcwd())
						local remote_root = vim.fn.input("Remote root [/app]: ", "/app")
						return {
							{
								localRoot = local_root,
								remoteRoot = remote_root,
							},
						}
					end,
					justMyCode = false,
				},

				-- NOVA: Attach to remote Python process
				{
					type = "python",
					request = "attach",
					name = "Attach to Remote Process",
					connect = function()
						local host = vim.fn.input("Host: ", "localhost")
						local port = tonumber(vim.fn.input("Port: ", "5678"))
						return {
							host = host,
							port = port,
						}
					end,
					pathMappings = {
						{
							localRoot = "${workspaceFolder}",
							remoteRoot = ".",
						},
					},
					justMyCode = false,
				},
			}

			-- Keymaps
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
			vim.keymap.set("n", "<leader>?", function()
				require("dapui").eval(nil, { enter = true })
			end)
			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<F12>", dap.restart)

			-- Keymap para debug info
			vim.keymap.set("n", "<leader>dp", function()
				local python_path = get_python_path()
				print("Using Python: " .. python_path)
				print("VIRTUAL_ENV: " .. (os.getenv("VIRTUAL_ENV") or "Not set"))
				print("Current working directory: " .. vim.fn.getcwd())
			end, { desc = "Print DAP Python info" })
		end,
	},
}
