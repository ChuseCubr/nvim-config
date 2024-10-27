return {
	{
		"folke/zen-mode.nvim",
		optional = false,
		cmd = { "ZenMode" },
		opts = {
			window = { width = 80 },
			plugins = {
				wezterm = { enabled = true },
				neovide = { enabled = true },
			},
			on_open = function ()
				vim.opt.background = 'light'
			end,
			on_close = function ()
				vim.opt.background = 'dark'
			end
		},
	},
}
