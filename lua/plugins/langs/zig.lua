return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "zig")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				zls = {},
			},
		},
	},
}
