return {
	"jbyuki/venn.nvim",
	cmd = "VBox",
	config = function()
		-- venn.nvim: enable or disable keymappings
		function _G.VennEnable()
			vim.cmd([[setlocal ve=all]])
			-- draw a line on HJKL keystokes
			vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
			vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
			vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
			vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
			-- draw a box by pressing "f" with visual selection
			vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
		end
		function _G.VennDisable()
			vim.cmd([[setlocal ve=]])
			vim.cmd([[mapclear <buffer>]])
		end
	end,
}
