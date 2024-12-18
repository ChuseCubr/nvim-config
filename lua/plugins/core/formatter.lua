return {
	-- Formatter
	{
		"stevearc/conform.nvim",
		dependencies = {
			-- Tools installer (dap, linter, formatter)
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				event = { "User VeryLazyFile" },
				opts = function(_, opts)
					opts = opts or {}
					opts.ensure_installed = opts.ensure_installed or {}
					table.insert(opts.ensure_installed, "stylua")
				end,
				config = function(_, opts)
					local mason_tool_installer = require("mason-tool-installer")
					mason_tool_installer.setup(opts)
					mason_tool_installer.run_on_start()
				end,
			},

			-- Keymap hints (alternative to `folke/which-key.nvim`)
			{
				"echasnovski/mini.clue",
				optional = true,
				opts = function(_, opts)
					opts = opts or {}
					opts.clues = opts.clues or {}
					vim.list_extend(opts.clues, {
						{ mode = "n", keys = "<leader>c", desc = "[C]ode" },
					})
				end,
			},
		},
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({
						async = true,
						timeout_ms = 5000,
					})
				end,
				desc = "[F]ormat",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
}
