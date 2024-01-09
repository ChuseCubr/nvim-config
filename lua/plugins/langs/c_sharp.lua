return {
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
			opts.servers.omnisharp = {
				enable_roslyn_analyzers = true,
				organize_imports_on_format = true,
				enable_import_completion = true,
			}
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
