vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.guicursor = ""

vim.opt.termguicolors = true
vim.g.nord_version = "arcticicestudio"
vim.g.transparent_background = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.breakindent = true
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.updatetime = 250
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.isfname:append("@-@")

vim.o.completeopt = "menuone,noselect"

vim.opt.showbreak = "↪"
vim.opt.list = true
vim.opt.listchars:append({
  -- New line
  eol = "↲",

  -- Spaces
  trail = "⋅",
  tab   = "→ ",
  nbsp  = "␣",

  -- Others
  extends  = "»",
  precedes = "«"
})

-- fix clipboard
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

-- python provider
if (vim.fn.has("unix") == 1) then
  vim.g.python3_host_prog = "$HOME/.config/nvim/venv/bin/python"
else
  vim.g.python3_host_prog = "$HOME/.config/nvim/venv/Scripts/python.exe"
end
