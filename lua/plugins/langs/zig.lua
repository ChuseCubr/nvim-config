return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			vim.g.zig_fmt_autosave = false
			table.insert(opts.ensure_installed, "zig")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				zls = { enable_autofix = false },
			},
		},
	},
}
