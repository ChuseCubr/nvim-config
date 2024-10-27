return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "php")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				intelephense = {}
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "pint")
		end,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft["php"] = { "pint" }
		end,
	},
}
