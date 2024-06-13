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

vim.o.wildmenu = true
vim.o.path = vim.o.path .. ",**"

-- indent options
vim.o.breakindent = true
vim.o.expandtab = false
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.o.timeoutlen = 300
vim.o.mouse = "a"

vim.o.linebreak = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.completeopt = "menu,menuone,preview,noinsert,noselect"
vim.g.python3_host_prog = "C:/Users/Chase/scoop/apps/python/current/python.exe"
