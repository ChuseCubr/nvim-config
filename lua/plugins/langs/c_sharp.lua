return {
	{ 'Hoffs/omnisharp-extended-lsp.nvim', lazy = true },
	{
		'nvim-treesitter/nvim-treesitter',
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { 'c_sharp' })
		end,
	},
	{
		'williamboman/mason.nvim',
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, 'csharpier')
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
		'stevearc/conform.nvim',
		optional = true,
		opts = {
			formatters_by_ft = {
				cs = { 'csharpier' },
			},
			formatters = {
				csharpier = {
					command = 'dotnet-csharpier',
					args = { '--write-stdout' },
				},
			},
		},
	},
}
