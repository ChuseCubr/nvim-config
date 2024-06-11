vim.cmd("colorscheme default")
vim.g.colors_name = "min-default"

-- resets
vim.api.nvim_set_hl(0, "Function", { fg = "NvimLightGray2" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "NvimLightGray2" })

-- dim
vim.api.nvim_set_hl(0, "Type", { fg = "NvimLightGray4" })
vim.api.nvim_set_hl(0, "Delimiter", { fg = "NvimLightGray4" })
vim.api.nvim_set_hl(0, "Special", { fg = "NvimLightGray4" })

-- highlights
vim.api.nvim_set_hl(0, "MatchParen", { fg = "NvimLightCyan", bg = "NvimDarkBlue" })
vim.api.nvim_set_hl(0, "Keyword", { fg = "NvimLightBlue" })

-- neovide term colors
vim.g.terminal_color_0 = "NvimLightGray2"
vim.g.terminal_color_1 = "NvimLightRed"
vim.g.terminal_color_2 = "NvimLightGreen"
vim.g.terminal_color_3 = "NvimLightYellow"
vim.g.terminal_color_4 = "NvimLightBlue"
vim.g.terminal_color_5 = "NvimLightMagenta"
vim.g.terminal_color_6 = "NvimLightCyan"
vim.g.terminal_color_7 = "NvimLightGray4"

vim.g.terminal_color_8 = vim.g.terminal_color_0
vim.g.terminal_color_9 = vim.g.terminal_color_1
vim.g.terminal_color_10 = vim.g.terminal_color_2
vim.g.terminal_color_11 = vim.g.terminal_color_3
vim.g.terminal_color_12 = vim.g.terminal_color_4
vim.g.terminal_color_13 = vim.g.terminal_color_5
vim.g.terminal_color_14 = vim.g.terminal_color_6
vim.g.terminal_color_15 = vim.g.terminal_color_7
