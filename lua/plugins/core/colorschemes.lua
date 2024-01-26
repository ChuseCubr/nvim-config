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

	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		config = function()
			local vscode = require("vscode")
			vscode.setup({ italic_comments = true })
			-- vscode.load("dark")
		end,
	},

	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		config = function()
			require("github-theme").setup({
				options = {
					styles = {
						comments = "italic",
					},
				}
			})

			-- vim.cmd.colorscheme("github_dark")
		end,
	},
}
