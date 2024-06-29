vim.g.colors_name = "min-default"

local prefix = vim.o.background == "dark" and "NvimLight" or "NvimDark"
local inverted_prefix = vim.o.background == "dark" and "NvimDark" or "NvimLight"

local function set_color(group, fg)
	if vim.o.background == "dark" then
		fg = "NvimLight" .. fg
		vim.api.nvim_set_hl(0, group, { fg = fg })
		return
	end

	local bg = "NvimLight" .. fg
	vim.api.nvim_set_hl(0, group, { fg = "NvimDarkGray2", bg = bg })
end

local function base_color(groups)
	local color = prefix .. "Gray2"

	if type(groups) == "string" then
		vim.api.nvim_set_hl(0, groups, { fg = color, bold = true })
		return
	end

	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { fg = color, bold = true })
	end
end

local function dimmed_color(groups)
	local color = prefix .. "Gray4"

	if type(groups) == "string" then
		vim.api.nvim_set_hl(0, groups, { fg = color })
		return
	end

	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { fg = color })
	end
end

-- resets
local base = {
	"Function",
	"Identifier",
	"Boolean",
	"Number",
	"Macro",
	"Tag",
	"@variable",
	"@label",
}

base_color(base)

-- dim
local dimmed = {
	"Type",
	"Delimiter",
	"Special",
	"Operator",
	"@module",
}

dimmed_color(dimmed)

-- highlights

set_color("Keyword", "Blue")
set_color("String", "Green")

set_color("DiagnosticError", "Red")
set_color("DiagnosticWarn", "Yellow")
set_color("DiagnosticInfo", "Cyan")
set_color("Todo", "Magenta")

-- manual sets
vim.api.nvim_set_hl(0, "Added", { fg = prefix .. "Green" })
vim.api.nvim_set_hl(0, "Removed", { fg = prefix .. "Red" })
vim.api.nvim_set_hl(0, "Changed", { fg = prefix .. "Yellow" })

vim.api.nvim_set_hl(0, "MatchParen", { fg = prefix .. "Cyan", bg = inverted_prefix .. "Blue" })

-- neovide term colors
vim.g.terminal_color_0 = "NvimLightGray4"
vim.g.terminal_color_1 = "NvimLightRed"
vim.g.terminal_color_2 = "NvimLightGreen"
vim.g.terminal_color_3 = "NvimLightYellow"
vim.g.terminal_color_4 = "NvimLightBlue"
vim.g.terminal_color_5 = "NvimLightMagenta"
vim.g.terminal_color_6 = "NvimLightCyan"
vim.g.terminal_color_7 = "NvimLightGray2"

vim.g.terminal_color_8 = vim.g.terminal_color_0
vim.g.terminal_color_9 = vim.g.terminal_color_1
vim.g.terminal_color_10 = vim.g.terminal_color_2
vim.g.terminal_color_11 = vim.g.terminal_color_3
vim.g.terminal_color_12 = vim.g.terminal_color_4
vim.g.terminal_color_13 = vim.g.terminal_color_5
vim.g.terminal_color_14 = vim.g.terminal_color_6
vim.g.terminal_color_15 = vim.g.terminal_color_7
