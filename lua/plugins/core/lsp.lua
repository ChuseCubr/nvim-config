return {
	{
		"neovim/nvim-lspconfig",
		event = { "User VeryLazyFile" },
		cmd = {
			"Mason",
			"MasonLog",
			"MasonUpdate",
			"MasonInstall",
			"MasonUninstall",
			"MasonToolsUpdate",
			"MasonToolsInstall",
			"MasonToolsUninstall",
			"LspInfo",
			"LspLog",
			"LspInstall",
			"LspUninstall",
		},
		dependencies = {
			-- LSP installer and configurer
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- -- Lsp progress info
			-- { "j-hui/fidget.nvim", tag = "legacy", config = true },

			-- Neovim-specific lua_ls configuration
			{
				{
					"folke/lazydev.nvim",
					ft = "lua", -- only load on lua files
					opts = {
						library = {
							-- See the configuration section for more details
							-- Load luvit types when the `vim.uv` word is found
							{ path = "luvit-meta/library", words = { "vim%.uv" } },
						},
					},
				},
				{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
				{ -- optional completion source for require statements and module annotations
					"hrsh7th/nvim-cmp",
					opts = function(_, opts)
						opts.sources = opts.sources or {}
						table.insert(opts.sources, {
							name = "lazydev",
							group_index = 0, -- set group index to 0 to skip loading LuaLS completions
						})
					end,
				},
				-- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
			},

			-- Fuzzy finder (alternative to `nvim-telescope/telescope.nvim`)
			{ "echasnovski/mini.pick", dependencies = { "echasnovski/mini.extra" } },

			-- Keymap hints (alternative to `folke/which-key.nvim`)
			{
				"echasnovski/mini.clue",
				optional = true,
				opts = function(_, opts)
					opts = opts or {}
					opts.clues = opts.clues or {}
					vim.list_extend(opts.clues, {
						{ mode = "n", keys = "<leader>c", desc = "[C]ode" },
						{ mode = "n", keys = "<leader>w", desc = "[W]orkspace" },
					})
				end,
			},
		},
		opts = function(_, opts)
			opts = opts or {}
			opts.servers = opts.servers or {}
			opts.servers.lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			}
		end,
		config = function(_, opts)
			local on_attach = function(_, bufnr)
				local nmap = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				local pick = function(scope)
					return function()
						require("mini.extra").pickers.lsp({ scope = scope })
					end
				end

				nmap("<leader>cr", vim.lsp.buf.rename, "[R]ename")
				nmap("<leader>ca", vim.lsp.buf.code_action, "[A]ction")
				nmap("<leader>cF", vim.lsp.buf.format, "[F]ormat (LSP)")

				nmap("gd", pick("definition"), "Definition")
				nmap("gr", pick("references"), "References")
				nmap("gI", pick("implementation"), "Implementation")
				nmap("<leader>cD", pick("type_definition"), "Type [D]efinition")
				nmap("<leader>cs", pick("document_symbol"), "[S]ymbols")
				nmap("<leader>ws", pick("workspace_symbol"), "[S]ymbols")

				-- See `:help K` for why this keymap
				nmap("K", vim.lsp.buf.hover, "Hover Docs")
				nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Docs")

				-- Lesser used LSP functionality
				nmap("gD", vim.lsp.buf.declaration, "Declaration")
				nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[A]dd Folder")
				nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[R]emove Folder")
				nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[L]ist Folders")
			end

			require("mason").setup()

			-- Ensure the servers above are installed
			local mason_lspconfig = require("mason-lspconfig")

			opts = opts or {}
			opts.servers = opts.servers or {}
			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(opts.servers),
			})

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local incremental_sync = false
			local flags
			if incremental_sync then
				flags = {}

				-- I wish I didn't have to do this,
				-- but some lsps' incremental sync suck ass for me
				vim.api.nvim_create_autocmd("BufWritePost", {
					group = vim.api.nvim_create_augroup("chuse_reload_on_save", { clear = true }),
					callback = function()
						vim.cmd("e")
					end,
				})
			else
				flags = {
					allow_incremental_sync = false,
					debounce_text_changes = 500,
				}
			end

			mason_lspconfig.setup_handlers({
				function(server_name)
					if (opts.servers[server_name] or {}).custom_setup_handler == nil then
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							on_attach = on_attach,
							settings = opts.servers[server_name],
							filetypes = (opts.servers[server_name] or {}).filetypes,
							-- flags = flags,
						})

						return
					end

					opts.servers[server_name].custom_setup_handler({
						capabilities = capabilities,
						on_attach = on_attach,
						flags = flags,
					})
				end,
			})
		end,
	},
}
