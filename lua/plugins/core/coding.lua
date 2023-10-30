return {
	-- Better text objects
	{ 'echasnovski/mini.ai', event = 'UIEnter', config = true },

	-- Commenter
	{
		'echasnovski/mini.comment',
		config = true,
		keys = { { 'gc', mode = { 'n', 'x' } } },
	},

	-- LSP Configuration & Plugins
	{
		'neovim/nvim-lspconfig',
		event = 'UIEnter',
		dependencies = {
			-- LSP installer and configurer
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',

			{ 'j-hui/fidget.nvim', tag = 'legacy', config = true },

			-- Neovim-specific lua_ls configuration
			'folke/neodev.nvim',

			-- Fuzzy finder (alternative to `nvim-telescope/telescope.nvim`)
			{ 'echasnovski/mini.pick', dependencies = { 'echasnovski/mini.extra' } },

			-- Keymap hints (alternative to `folke/which-key.nvim`)
			{
				'echasnovski/mini.clue',
				opts = function(_, opts)
					opts = opts or {}
					opts.clues = opts.clues or {}
					vim.list_extend(opts.clues, {
						{ mode = 'n', keys = '<leader>c', desc = '[C]ode' },
						{ mode = 'n', keys = '<leader>w', desc = '[W]orkspace' },
					})
				end,
			},
		},

		config = function(_, opts)
			local on_attach = function(_, bufnr)
				local nmap = function(keys, func, desc)
					vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
				end

				local pick = function(scope)
					return function()
						require('mini.extra').pickers.lsp({ scope = scope })
					end
				end

				nmap('<leader>cr', vim.lsp.buf.rename, '[R]ename')
				nmap('<leader>ca', vim.lsp.buf.code_action, '[A]ction')

				nmap('gd', pick('definition'), 'Definition')
				nmap('gr', pick('references'), 'References')
				nmap('gI', pick('implementation'), 'Implementation')
				nmap('<leader>cD', pick('type_definition'), 'Type [D]efinition')
				nmap('<leader>cs', pick('document_symbol'), '[S]ymbols')
				nmap('<leader>ws', pick('workspace_symbol'), '[S]ymbols')

				-- See `:help K` for why this keymap
				nmap('K', vim.lsp.buf.hover, 'Hover Docs')
				nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Docs')

				-- Lesser used LSP functionality
				nmap('gD', vim.lsp.buf.declaration, 'Declaration')
				nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[A]dd Folder')
				nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[R]emove Folder')
				nmap('<leader>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, '[L]ist Folders')

				nmap('<leader>cf', vim.lsp.buf.format, '[F]ormat')
			end

			-- mason-lspconfig requires that these setup functions are called in this order
			-- before setting up the servers.
			require('mason').setup()
			require('mason-lspconfig').setup()

			opts = opts or {}
			local servers = opts.servers or {}
			servers.lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			}

			-- Setup neovim lua configuration
			require('neodev').setup()

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

			-- Ensure the servers above are installed
			local mason_lspconfig = require('mason-lspconfig')

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require('lspconfig')[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})
		end,
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
		config = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')
			require('luasnip.loaders.from_vscode').lazy_load()
			luasnip.config.setup({})

			---@diagnostic disable-next-line
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete({}),
					['<CR>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				},
			})
		end,
	},

	{
		'stevearc/aerial.nvim',
		lazy = false,
		config = true,
		-- Optional dependencies
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons'
		},
		keys = {
			{ '<leader>co', '<cmd>AerialToggle!<cr>', desc = '[O]utline' },
			{ '[s', '<cmd>AerialPrev<cr>', desc = 'Prev symbol' },
			{ ']s', '<cmd>AerialNext<cr>', desc = 'Next symbol' },
		},
	}
}
