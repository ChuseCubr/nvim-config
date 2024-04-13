-- Install package manager
--	https://github.com/folke/lazy.nvim
--	`:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
