return {
	-- Formatter
	{
		"stevearc/conform.nvim",
		dependencies = {
			-- Tools installer (dap, linter, formatter)
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				event = "UIEnter",
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
		},
		keys = { "<leader>" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
			vim.keymap.set("n", "<leader>cf", require("conform").format, { desc = "[F]ormat" })
		end,
	},
}
