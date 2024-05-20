vim.cmd.colorscheme("default")
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
