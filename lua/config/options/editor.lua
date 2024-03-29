-- Sync clipboard between OS and Neovim.
--	Remove this option if you want your OS clipboard to remain independent.
--	See `:help 'clipboard'`
-- vim.o.clipboard = "unnamedplus"

-- file opts
vim.o.autoread = true
vim.o.undofile = true
vim.o.updatetime = 250

-- search settings
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false

-- indent options
vim.o.breakindent = true
vim.o.expandtab = false
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.o.timeoutlen = 300
vim.o.mouse = "a"
vim.o.scrolloff = 5

vim.o.linebreak = true

vim.o.completeopt = "menu,menuone,preview,noinsert,noselect"
vim.g.python3_host_prog = "C:/Users/Chase/scoop/apps/python/current/python.exe"
