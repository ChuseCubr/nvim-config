-- custom events for plugin loading
-- I want some plugins to load only when opening/creating a file,
-- but I want them to load after VeryLazy
--
-- for injection, see `config/lazy.lua`

local custom_event_group = vim.api.nvim_create_augroup("chuse_custom_events", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = custom_event_group,
	callback = function()
		-- if not set, we opened a file/folder
		-- opening a file/folder emits BufReadPost before VeryLazy
		if not vim.g._chuse_very_lazy_starter then
			vim.g._chuse_very_lazy_starter = false
			return
		end

		vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazyFile" })
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	group = custom_event_group,
	callback = function()
		-- if already set, we didn't open a file/folder
		-- opening neovim without a file/folder emits VeryLazy before BufReadPost
		if vim.g._chuse_very_lazy_starter == false then
			vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazyFile" })

			-- reload file because on_attach won't be invoked after VeryLazy
			vim.cmd("e")

			local stats = require("lazy").stats()
			vim.print("Loaded "
				.. stats.loaded
				.. "/"
				.. stats.count
				.. " packages in "
				.. math.floor(stats.startuptime)
				.. "ms")
			return
		end

		vim.g._chuse_very_lazy_starter = true
		vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazyStarter" })
	end,
})
