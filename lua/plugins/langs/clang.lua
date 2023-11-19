return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "c")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				clangd = {},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "clang-format")
		end,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.c = { "clang_format" }
		end,
	},
}
