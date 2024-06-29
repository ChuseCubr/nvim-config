vim.cmd("hi clear")
vim.cmd("syntax reset")
vim.g.colors_name = "min-default"

local prefix = vim.o.background == "dark" and "NvimLight" or "NvimDark"
local inverted_prefix = vim.o.background == "dark" and "NvimDark" or "NvimLight"

local function set_color(group, fg, bg)
	if vim.o.background == "dark" then
		fg = "NvimLight" .. fg
		vim.api.nvim_set_hl(0, group, { fg = fg, bg = bg })
		return
	end

	fg = "NvimLight" .. fg
	bg = bg or "NvimDarkGray2"
	vim.api.nvim_set_hl(0, group, { fg = bg, bg = fg })
end

local function base_color(groups)
	local opts = { fg = prefix .. "Gray2", bold = true }

	if type(groups) == "string" then
		vim.api.nvim_set_hl(0, groups, opts)
		return
	end

	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

local function dimmed_color(groups)
	local opts = { fg = prefix .. "Gray4" }

	if type(groups) == "string" then
		vim.api.nvim_set_hl(0, groups, opts)
		return
	end

	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

-- resets
local base = {
	"Boolean",
	"Float",
	"Function",
	"Identifier",
	"Label",
	"Macro",
	"Number",
	"Tag",
	"@attribute.builtin",
	"@constant.builtin",
	"@function.builtin",
	"@tag.builtin",
	"@variable",
	"@variable.builtin",
	"@variable.parameter.builtin",
	"MiniStarterItem",
}

base_color(base)

-- dim
local dimmed = {
	"Delimiter",
	"Operator",
	"Special",
	"Structure",
	"Type",
}

dimmed_color(dimmed)

-- highlights
set_color("Keyword", "Blue")

set_color("String", "Green")
set_color("Character", "Green")
set_color("SpecialChar", "Green")

set_color("MiniStarterItemPrefix", "Yellow")
set_color("MiniStarterQuery", "Green")
set_color("MiniStarterCurrent", "Blue")
set_color("MiniStarterInactive", "Gray2", "Gray2")

set_color("DiagnosticError", "Red")
set_color("DiagnosticWarn", "Yellow")
set_color("DiagnosticInfo", "Cyan")
set_color("Todo", "Magenta")

set_color("Added", "Green")
set_color("Removed", "Red")
set_color("Changed", "Yellow")

-- manual sets
vim.api.nvim_set_hl(0, "MatchParen", { fg = prefix .. "Cyan", bg = inverted_prefix .. "Blue" })

-- neovide term colors
vim.g.terminal_color_0 = prefix .. "Gray4"
vim.g.terminal_color_1 = prefix .. "Red"
vim.g.terminal_color_2 = prefix .. "Green"
vim.g.terminal_color_3 = prefix .. "Yellow"
vim.g.terminal_color_4 = prefix .. "Blue"
vim.g.terminal_color_5 = prefix .. "Magenta"
vim.g.terminal_color_6 = prefix .. "Cyan"
vim.g.terminal_color_7 = prefix .. "Gray2"

vim.g.terminal_color_8 = vim.g.terminal_color_0
vim.g.terminal_color_9 = vim.g.terminal_color_1
vim.g.terminal_color_10 = vim.g.terminal_color_2
vim.g.terminal_color_11 = vim.g.terminal_color_3
vim.g.terminal_color_12 = vim.g.terminal_color_4
vim.g.terminal_color_13 = vim.g.terminal_color_5
vim.g.terminal_color_14 = vim.g.terminal_color_6
vim.g.terminal_color_15 = vim.g.terminal_color_7
