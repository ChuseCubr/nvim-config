return {
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
			})
			-- vim.cmd.colorscheme("rose-pine")
		end,
	},

	{
		"gbprod/nord.nvim",
		lazy = false,
		config = function()
			-- vim.cmd.colorscheme("nord")
		end,
	},

	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		opts = {
			contrast = "hard",
			overrides = {
				SignColumn = { bg = "#1d2021" },
			},
		},
		config = function(_, opts)
			require("gruvbox").setup(opts)
			-- vim.cmd.colorscheme("gruvbox")
		end,
	},

	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		config = function()
			local vscode = require("vscode")
			vscode.setup({ italic_comments = true })
			-- vscode.load("dark")
		end,
	},

	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		config = function()
			require("github-theme").setup({
				options = {
					styles = {
						comments = "italic",
					},
				},
			})
			-- vim.cmd.colorscheme("github_dark")
		end,
	},

	{
		"themercorp/themer.lua",
		lazy = false,
		opts = function()
			local base = "#191724"
			local surface = "#1f1d2e"
			local overlay = "#26233a"
			local muted = "#6e6a86"
			local subtle = "#908caa"
			local text = "#e0def4"
			local love = "#eb6f92"
			local gold = "#f6c177"
			local rose = "#ebbcba"
			local pine = "#31748f"
			local foam = "#9ccfd8"
			local iris = "#c4a7e7"
			local highlight_low = "#21202e"
			local highlight_med = "#403d52"
			local highlight_high = "#524f67"

			local resets = {
				"character",
				"comment",
				"conditional",
				"constant",
				"constantBuiltIn",
				"constructor",
				"field",
				"function",
				"functionBuiltIn",
				"identifier",
				"include",
				"keyword",
				"keywordBuiltIn",
				"number",
				"operator",
				"parameter",
				"property",
				"punctuation",
				"statement",
				"string",
				"struct",
				"type",
				"typeBuiltIn",
				"todo",
				"uri",
				"variable",
				"variableBuiltIn",
			}
			local styles = {}

			for _, v in ipairs(resets) do
				styles[v] = { fg = text }
			end

			styles.character = { fg = foam }
			styles.comment = { fg = gold }
			styles.keyword = { fg = pine }
			styles.keywordBuiltIn = { fg = pine }
			styles.number = { fg = iris }
			styles.punctuation = { fg = subtle }
			styles.string = { fg = foam }
			styles.type = { fg = subtle }
			styles.typeBuiltIn = { fg = subtle }

			return {
				colorscheme = "rose_pine", -- default colorscheme
				transparent = true,
				styles = styles,
				remaps = {
					highlights = {
						rose_pine = {
							base = {
								CmpMenu = { bg = "none" },
								DiagnosticUnnecessary = { fg = muted },
								IncSearch = { fg = gold, bg = base },
								MatchParen = { fg = text, bg = pine },
								MiniPickMatchCurrent = { bg = highlight_med },
								ThemerMatch = { bg = highlight_med },
								ThemerPreProc = { fg = text },
								ThemerSearchResult = { fg = base, bg = gold },
								ThemerSelected = { bg = highlight_high },
							},
						},
					},
				},
			}
		end,
	},
}
