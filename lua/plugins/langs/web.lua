return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"html",
				"css",
				"javascript",
				"typescript",
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				html = {},
				cssls = {},
				tsserver = {},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "prettier")
		end,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			local fts = {
				"html",
				"css",
				"javascript",
			}
			for _, ft in ipairs(fts) do
				opts.formatters_by_ft[ft] = { "prettier" }
			end
		end,
	},
}
