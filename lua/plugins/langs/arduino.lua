return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "arduino")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.servers = opts.servers or {}
			opts.servers.arduino_language_server = {}

			local path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason") .. "/bin/arduino-language-server.CMD"

			-- omnisharp is weird, gotta use a custom handler
			opts.servers.arduino_language_server.custom_setup_handler = function(setup_opts)
				local default_capabilities = vim.lsp.protocol.make_client_capabilities()
				default_capabilities.textDocument.semanticTokens = vim.NIL
				default_capabilities.workspace.semanticTokens = vim.NIL

				require("lspconfig").arduino_language_server.setup({
					capabilities = default_capabilities,
					on_attach = setup_opts.on_attach,
					-- flags = setup_opts.flags,
					cmd = { path, "-cli-config", "$env:LOCALAPPDATA/Arduino15/arduino-cli.yaml" },
				})
			end
		end,
	},
}
