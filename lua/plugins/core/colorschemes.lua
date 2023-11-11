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
		-- lazy = false,
		-- config = function() vim.cmd.colorscheme('nord') end,
	},
}
