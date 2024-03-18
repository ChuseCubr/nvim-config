return {
	-- Startup screen
	{
		"echasnovski/mini.starter",
		version = false,
		event = "VimEnter",
		opts = {
			header = function()
				local version = vim.version()
				return "NVIM v" .. version.major .. "." .. version.minor .. "." .. version.patch
			end,
			items = {
				{
					name = "SF Files",
					action = "lua require('mini.pick').builtin.files()",
					section = "Search",
				},
				{
					name = "GF Git files",
					action = "lua require('mini.extra').pickers.git_files()",
					section = "Search",
				},
				{
					name = "SG Grep",
					action = "lua require('mini.pick').builtin.grep_live()",
					section = "Search",
				},

				{
					name = "L Lazy",
					action = "Lazy",
					section = "Menus",
				},
				{
					name = "M Mason",
					action = "Mason",
					section = "Menus",
				},
				{
					name = "GG lazygit",
					action = "LazyGit",
					section = "Menus",
				},

				{
					name = "E New buffer",
					action = "enew",
					section = "Actions",
				},
				{
					name = "N File browser",
					action = "lua MiniFiles.open()",
					section = "Actions",
				},
				{
					name = "Q Quit Neovim",
					action = "qall",
					section = "Actions",
				},
			},
			footer = function()
				local stats = require("lazy").stats()
				return "Loaded "
					.. stats.loaded
					.. "/"
					.. stats.count
					.. " packages in "
					.. math.floor(stats.startuptime)
					.. "ms"
			end,
		},
		config = function(_, opts)
			local starter = require("mini.starter")
			opts = opts or {}
			opts.items = opts.items or {}
			opts.query_updaters = opts.query_updaters or ""

			for _, item in ipairs(opts.items) do
				local hotkey = string.match(item.name, "[^%s]+"):lower()
				opts.query_updaters = opts.query_updaters .. hotkey
			end

			starter.setup(opts)
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazyStarter",
				callback = function()
					require("mini.starter").refresh()
				end,
			})
		end,
	},

	-- Indent lines
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "VeryLazyFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"lazy",
					"mason",
					"notify",
				},
			},
		},
		main = "ibl",
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons", config = true },
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				-- component_separators = { left = '│', right = '│' },
				component_separators = { left = "", right = "" },
				section_separators = { left = "▒", right = "▒" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					{
						"diff",
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
						source = function()
							---@diagnostic disable-next-line
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
				},
				lualine_c = { "filename" },
				lualine_x = { "diagnostics", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		},
	},

	-- Automatically highlight patterns
	{
		"echasnovski/mini.hipatterns",
		event = { "VeryLazyFile" },
		version = false,
		opts = {
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
				-- trailspace = { pattern = "%f[%s]%s*$", group = "MiniHipatternsTrailspace" },
			},
		},
		config = function(_, opts)
			opts = opts or {}
			opts.highlighters = opts.highlighters or {}
			opts.highlighters["hex_color"] = require("mini.hipatterns").gen_highlighter.hex_color()

			vim.api.nvim_set_hl(0, "MiniHipatternsFixme", {
				bg = vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg,
				fg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
			})

			vim.api.nvim_set_hl(0, "MiniHipatternsHack", {
				bg = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }).fg,
				fg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
			})

			vim.api.nvim_set_hl(0, "MiniHipatternsTodo", {
				bg = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }).fg,
				fg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
			})

			vim.api.nvim_set_hl(0, "MiniHipatternsNote", {
				bg = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }).fg,
				fg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
			})

			-- vim.api.nvim_set_hl(0, "MiniHipatternsTrailspace", {
			-- 	bg = vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg,
			-- 	fg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
			-- })

			require("mini.hipatterns").setup(opts)
		end,
	},
}
