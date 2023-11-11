return {
	{
		"neovim/nvim-lspconfig",
		event = "UIEnter",
		dependencies = {
			-- LSP installer and configurer
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Lsp progress info
			{ "j-hui/fidget.nvim", tag = "legacy", config = true },

			-- Neovim-specific lua_ls configuration
			"folke/neodev.nvim",

			-- Fuzzy finder (alternative to `nvim-telescope/telescope.nvim`)
			{ "echasnovski/mini.pick", dependencies = { "echasnovski/mini.extra" } },

			-- Keymap hints (alternative to `folke/which-key.nvim`)
			{
				"echasnovski/mini.clue",
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

			-- Setup neovim lua configuration
			require("neodev").setup()

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

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = opts.servers[server_name],
						filetypes = (opts.servers[server_name] or {}).filetypes,
					})
				end,
			})
		end,
	},
}
