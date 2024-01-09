-- Install package manager
--	https://github.com/folke/lazy.nvim
--	`:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- utils for custom event handling
---@param handler LazyEventHandler
---@param event string
---@param event_table string | table<string>
local function inject_event(handler, event, event_table)
	local event_opts = { id = event, event = event_table }
	handler.mappings[event] = event_opts
	handler.mappings["User " .. event] = event_opts
end

---@param handler LazyEventHandler
---@param event string
local function inject_user_event(handler, event)
	local event_opts = { id = event, event = "User", pattern = event }
	handler.mappings[event] = event_opts
	handler.mappings["User " .. event] = event_opts
end

-- inject custom events (see `config/autocmds/events.lua`)
local event_handler = require("lazy.core.handler.event")

inject_user_event(event_handler, "VeryLazyFile")
inject_user_event(event_handler, "VeryLazyStarter")

require("lazy").setup({
	spec = {
		{ import = "plugins/extras" },
		{ import = "plugins/langs" },
		{ import = "plugins/core" },
	},
	defaults = {
		lazy = true,
		version = false,
	},
	checker = { enabled = false },
})
