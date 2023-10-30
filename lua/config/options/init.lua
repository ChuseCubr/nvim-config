-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--	Remove this option if you want your OS clipboard to remain independent.
--	See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.title = true
vim.o.laststatus = 3
vim.o.guicursor = 'n-v-c-i:block'

vim.o.colorcolumn = '80'

vim.o.showbreak = '↪'
vim.o.list = true

vim.opt.listchars:append({
	-- New line
	eol = '↲',

	-- Spaces
	trail = '⋅',
	tab = '→ ',
	nbsp = '␣',

	-- Others
	extends = '»',
	precedes = '«',
})

vim.o.expandtab = false
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.scrolloff = 5

vim.g.python3_host_prog = 'C:/Users/Chase/scoop/apps/python/current/python.exe'

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
