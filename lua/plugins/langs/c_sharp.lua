return {
	'Hoffs/omnisharp-extended-lsp.nvim',
	{
		'nvim-treesitter/nvim-treesitter',
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, 'c_sharp')
		end,
	},
	{
		'neovim/nvim-lspconfig',
		opts = {
			servers = {
				omnisharp = {},
			},
		},
	},
	{
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, 'csharpier')
		end,
	},
	{
		'stevearc/conform.nvim',
		opts = function(_, opts)
			opts = opts or {}
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.cs = { 'csharpier' }
		end
	},
}
