-- universal highlights for all colorschemes

local colorscheme_name = vim.g.colors_name or "default"

local function reload_colorscheme()
	colorscheme_name = vim.g.colors_name or "default"
	vim.cmd.colorscheme(colorscheme_name)
end

-- highlight comments
local highlight_comments = true

function _G.HighlightCommentsEnable()
	highlight_comments = true
	reload_colorscheme()
	vim.api.nvim_set_hl(0, "Comment", { ctermfg = 11, fg = "NvimLightYellow" })
end

function _G.HighlightCommentsDisable()
	highlight_comments = false
	reload_colorscheme()
end

function _G.HighlightCommentsToggle()
	highlight_comments = not highlight_comments
	if highlight_comments then
		_G.HighlightCommentsEnable()
	else
		_G.HighlightCommentsDisable()
	end
end

local highlight_comments_group = vim.api.nvim_create_augroup("chuse_comments", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = highlight_comments_group,
	callback = function()
		if highlight_comments ~= true then
			return
		end
		vim.api.nvim_set_hl(0, "Comment", { ctermfg = 11, fg = "NvimLightYellow" })
	end,
})

-- transparent background
local transparent_background = true

function _G.TransparentBackgroundEnable()
	transparent_background = true
	vim.api.nvim_set_hl(0, "Normal", { bg = nil })
	reload_colorscheme()
end

function _G.TransparentBackgroundDisable()
	transparent_background = false
	reload_colorscheme()
end

function _G.TransparentBackgroundToggle()
	transparent_background = not transparent_background
	if highlight_comments then
		_G.TransparentBackgroundEnable()
	else
		_G.TransparentBackgroundDisable()
	end
end

local transparent_background_group = vim.api.nvim_create_augroup("chuse_background", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = transparent_background_group,
	callback = function()
		if vim.g.neovide or transparent_background ~= true then
			return
		end
		vim.api.nvim_set_hl(0, "Normal", { bg = nil })
	end,
})

vim.api.nvim_exec_autocmds("ColorScheme", {})
