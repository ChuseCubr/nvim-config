require("config.options")
if vim.fn.has("win32") == 1 then
	require("config.options.windows")
else
	require("config.options.windows")
end

if vim.g.neovide then
	require("config.options.neovide")
end

require("config.keymaps")
require("config.autocmds")
require("config.autocmds.templates")
require("config.lazy")
