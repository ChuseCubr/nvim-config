return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = 'UIEnter',
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
	{
		'nvim-lualine/lualine.nvim',
		event = 'UIEnter',
		dependencies = { 'nvim-tree/nvim-web-devicons', config = true },
		opts = {
			options = {
				icons_enabled = true,
				theme = 'auto',
				-- component_separators = { left = '│', right = '│' },
				component_separators = { left = '', right = '' },
				section_separators = { left = '▒', right = '▒' },
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
				}
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = {
					'branch',
					{
						'diff',
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
									removed = gitsigns.removed
								}
							end
						end,
					},
				},
				lualine_c = { 'filename', },
				lualine_x = { 'diagnostics', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		},
	},

	{
		'echasnovski/mini.hipatterns',
		event = 'UIEnter',
		version = false,
		opts = {
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
				hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
				todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
				note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
				trailspace = { pattern = '%f[%s]%s*$', group = 'MiniHipatternsTrailspace' },
			},
		},
		config = function(_, opts)
			opts = opts or {}
			opts.highlighters = opts.highlighters or {}
			opts.highlighters['hex_color'] = require('mini.hipatterns').gen_highlighter.hex_color()

			vim.api.nvim_set_hl(0, 'MiniHipatternsFixme', {
				bg = vim.api.nvim_get_hl(0, { name = 'DiagnosticError' }).fg,
				fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg,
			})

			vim.api.nvim_set_hl(0, 'MiniHipatternsHack', {
				bg = vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn' }).fg,
				fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg,
			})

			vim.api.nvim_set_hl(0, 'MiniHipatternsTodo', {
				bg = vim.api.nvim_get_hl(0, { name = 'DiagnosticInfo' }).fg,
				fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg,
			})

			vim.api.nvim_set_hl(0, 'MiniHipatternsNote', {
				bg = vim.api.nvim_get_hl(0, { name = 'DiagnosticHint' }).fg,
				fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg,
			})

			vim.api.nvim_set_hl(0, 'MiniHipatternsTrailspace', {
				bg = vim.api.nvim_get_hl(0, { name = 'DiagnosticError' }).fg,
				fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg,
			})

			require('mini.hipatterns').setup(opts)
		end
	},
}
