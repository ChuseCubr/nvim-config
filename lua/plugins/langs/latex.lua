return {
	{
		"jbyuki/nabla.nvim",
		keys = {
			{ "<leader>m", desc = "[M]ath preview" },
		},
		config = function()
			vim.keymap.set("n", "<leader>m", require("nabla").popup, { desc = "[M]ath preview" })
		end,
	},
}
