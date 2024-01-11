return {
	 "Hoffs/omnisharp-extended-lsp.nvim",

	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "c_sharp")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.servers = opts.servers or {}
			opts.servers.omnisharp = {}

			-- omnisharp is weird, gotta use a custom handler
			opts.servers.omnisharp.custom_setup_handler = function(setup_opts)
				require("lspconfig").omnisharp.setup({
					capabilities = setup_opts.capabilities,
					on_attach = setup_opts.on_attach,
					flags = setup_opts.flags,

					-- for some reason, settings weren't recognized when under `settings`
					-- so take 'em out
					enable_roslyn_analyzers = true,
					organize_imports_on_format = true,
					enable_import_completion = true,
					handlers = {
						["textDocument/definition"] = function(...)
							return require("omnisharp_extended").handler(...)
						end,
					},
				})
			end
		end,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		dependencies = {
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = function(_, opts)
					opts = opts or {}
					opts.ensure_installed = opts.ensure_installed or {}
					table.insert(opts.ensure_installed, "csharpier")
				end,
			},
		},
		opts = {
			formatters_by_ft = {
				cs = { "csharpier" },
			},
			formatters = {
				csharpier = {
					command = "dotnet-csharpier",
					args = { "--write-stdout" },
				},
			},
		},
	},
}
