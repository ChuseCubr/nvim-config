return {
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		event = 'UIEnter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
		config = function()
			-- [[ Configure Treesitter ]]
			-- See `:help nvim-treesitter`
			-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
			vim.defer_fn(function()
				---@diagnostic disable-next-line
				require('nvim-treesitter.configs').setup {
					-- Add languages to be installed here that you want installed for treesitter
					ensure_installed = {
						'bash',
						'c',
						'cpp',
						'diff',
						'html',
						'javascript',
						'json',
						'lua',
						'markdown',
						'python',
						'query',
						'regex',
						'toml',
						'typescript',
						'vim',
						'vimdoc',
						'yaml',
					},

					-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
					auto_install = true,

					highlight = { enable = true },
					indent = { enable = true },
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = '<c-space>',
							node_incremental = '<c-space>',
							scope_incremental = '<c-s>',
							node_decremental = '<M-space>',
						},
					},
					textobjects = {
						select = {
							enable = true,
							lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
							keymaps = {
								-- You can use the capture groups defined in textobjects.scm
								['aa'] = '@parameter.outer',
								['ia'] = '@parameter.inner',
								['af'] = '@function.outer',
								['if'] = '@function.inner',
								['ac'] = '@class.outer',
								['ic'] = '@class.inner',
							},
						},
						move = {
							enable = true,
							set_jumps = true, -- whether to set jumps in the jumplist
							goto_next_start = {
								[']f'] = '@function.outer',
								[']c'] = '@class.outer',
							},
							goto_next_end = {
								[']F'] = '@function.outer',
								[']C'] = '@class.outer',
							},
							goto_previous_start = {
								['[f'] = '@function.outer',
								['[c'] = '@class.outer',
							},
							goto_previous_end = {
								['[F'] = '@function.outer',
								['[C'] = '@class.outer',
							},
						},
					},
				}
			end, 0)

			-- When in diff mode, we want to use the default
			-- vim text objects c & C instead of the treesitter ones.
			local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
			local configs = require("nvim-treesitter.configs")
			for name, fn in pairs(move) do
				if name:find("goto") == 1 then
					move[name] = function(q, ...)
						if vim.wo.diff then
							local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
							for key, query in pairs(config or {}) do
								if q == query and key:find("[%]%[][cC]") then
									vim.cmd("normal! " .. key)
									return
								end
							end
						end
						return fn(q, ...)
					end
				end
			end
		end,
	},
}
