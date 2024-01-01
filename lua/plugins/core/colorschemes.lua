return {
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		config = function()
			vim.cmd.colorscheme("rose-pine")
		end,
	},

	{
		"gbprod/nord.nvim",
		lazy = false,
		config = function()
			-- 	vim.cmd.colorscheme("nord")
		end,
	},

	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		opts = {
			contrast = "hard",
			overrides = {
				SignColumn = { bg = "#1d2021" },
			},
		},
		config = function(_, opts)
			require("gruvbox").setup(opts)
			-- vim.cmd.colorscheme("gruvbox")
		end,
	},
}
