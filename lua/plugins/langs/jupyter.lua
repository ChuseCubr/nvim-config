return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "python")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				pyright = {}
			},
		},
	},

	{
		"kiyoon/jupynium.nvim",
		event = "BufEnter *.ju.py",
		build = "pip3 install --user .",
		-- build = "conda run --no-capture-output -n jupynium pip install .",
		-- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
	},

	{
		"hrsh7th/nvim-cmp",
		optional = true,
		opts = function(_, opts)
			local cmp = require("cmp")
			local compare = cmp.config.compare

			opts = opts or {}
			opts.sources = opts.sources or {}
			table.insert(opts.sources, { name = "jupynium", priority = 1000 })
			opts.sorting = {
					priority_weight = 1.0,
					comparators = {
						compare.score,
						compare.recently_used,
						compare.locality,
					},
				}
		end
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "autopep8")
		end,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft["python"] = { "autopep8" }
		end,
	},
}
