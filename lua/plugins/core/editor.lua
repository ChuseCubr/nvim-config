return {
	-- Automatic indent settings detection
	{ "tpope/vim-sleuth", event = { "User VeryLazyFile" } },

	-- File browser
	{
		"echasnovski/mini.files",
		event = "BufEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{
				"<leader>n",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
				end,
				desc = "Browser (Buffer)",
			},
			{
				"<leader>N",
				function()
					require("mini.files").open(vim.uv.cwd(), true)
				end,
				desc = "Browser (CWD)",
			},
		},
		opts = {
			windows = {
				preview = true,
				width_focus = 30,
				width_nofocus = 15,
				width_preview = 80,
			},
			mappings = {
				close = "<leader>n",
				go_in_plus = "l",
				go_in = "L",
				go_out_plus = "h",
				go_out = "H",
			},
		},
		config = function(_, opts)
			local show_dotfiles = false

			local filter_show = function(_)
				return true
			end

			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				require("mini.files").refresh({ content = { filter = new_filter } })
			end

			opts = opts or {}
			opts.content = opts.content or {}
			vim.list_extend(opts.content, { filter = show_dotfiles or filter_show or filter_hide })
			require("mini.files").setup(opts)

			local system_open = function()
				local file_path = require("mini.files").get_fs_entry().path
				if vim.fn.has("win32") == 1 then
					os.execute("start " .. file_path)
				elseif vim.fn.has("unix") == 1 then
					os.execute("xdg-open " .. file_path)
				else
					os.execute("open " .. file_path)
				end
			end

			local callback = function(args)
				local buf_id = args.data.buf_id

				vim.keymap.set("n", "g.", toggle_dotfiles, {
					buffer = buf_id,
					desc = "Toggle dotfiles",
				})

				vim.keymap.set("n", "gx", system_open, {
					buffer = buf_id,
					desc = "Open with system default",
				})
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = callback,
			})
		end,
	},

	-- Fuzzy finder (alternative to `nvim-telescope/telescope.nvim`)
	{
		"echasnovski/mini.pick",
		version = false,
		dependencies = {
			"echasnovski/mini.extra",
			{
				"echasnovski/mini.clue",
				optional = true,
				opts = function(_, opts)
					opts = opts or {}
					opts.clues = opts.clues or {}
					vim.list_extend(opts.clues, {
						{ mode = "n", keys = "<leader>g", desc = "[G]it" },
						{ mode = "n", keys = "<leader>s", desc = "[S]earch" },
					})
				end,
			},
		},
		keys = { "<leader>" },
		opts = {
			mappings = {
				choose_marked = "<c-q>",
			},
		},
		config = function(_, opts)
			vim.ui.select = require("mini.pick").ui_select

			-- keymaps here instead of `keys` for when required by another plugin
			local builtin = require("mini.pick").builtin
			local extra = require("mini.extra").pickers

			vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Buffers" })
			vim.keymap.set("n", "<leader>sf", builtin.files, { desc = "[F]iles" })
			vim.keymap.set("n", "<leader>sh", builtin.help, { desc = "[H]elp" })
			vim.keymap.set("n", "<leader>sw", function()
				builtin.grep({ pattern = vim.fn.expand("<cword>") })
			end, { desc = "Current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.grep_live, { desc = "[G]rep" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[R]esume" })

			vim.keymap.set("n", "<leader>sk", extra.keymaps, { desc = "[K]eymaps" })
			vim.keymap.set("n", "<leader>/", extra.buf_lines, { desc = "[/] Search Here" })
			vim.keymap.set("n", "<leader>sd", extra.diagnostic, { desc = "[D]iagnostics" })
			vim.keymap.set("n", "<leader>sc", extra.hl_groups, { desc = "[C]olors" })

			vim.keymap.set("n", "<leader>gf", extra.git_files, { desc = "[F]iles" })
			vim.keymap.set("n", "<leader>gc", extra.git_commits, { desc = "[C]ommits" })
			vim.keymap.set("n", "<leader>gh", extra.git_hunks, { desc = "[H]unks" })
			vim.keymap.set("n", "<leader>gb", extra.git_branches, { desc = "[B]ranches" })

			vim.keymap.set("n", "gq", function()
				extra.list({ scope = "quickfix" })
			end, { desc = "Quickfix" })
			vim.keymap.set("n", "gl", function()
				extra.list({ scope = "location" })
			end, { desc = "Location" })

			require("mini.pick").setup(opts)
		end,
	},

	-- Keymap hints (alternative to `folke/which-key.nvim`)
	{
		"echasnovski/mini.clue",
		version = false,
		keys = {
			{ "[", mode = "n" },
			{ "]", mode = "n" },
			{ "<c-w>", mode = "n" },
			{ "<c-x>", mode = "i" },
			{ "g", mode = { "n", "x" } },
			{ "z", mode = { "n", "x" } },
			{ "`", mode = { "n", "x" } },
			{ "'", mode = { "n", "x" } },
			{ '"', mode = { "n", "x" } },
			{ "<c-r>", mode = { "i", "c" } },
			{ "<leader>", mode = { "n", "x" } },
		},
		opts = {
			triggers = {
				-- Leader triggers
				{ mode = "n", keys = "<leader>" },
				{ mode = "x", keys = "<leader>" },

				-- built-in completion
				{ mode = "i", keys = "<c-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				-- registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<c-r>" },
				{ mode = "c", keys = "<c-r>" },

				-- window commands
				{ mode = "n", keys = "<c-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },

				{ mode = "n", keys = "[" },
				{ mode = "n", keys = "]" },
			},

			window = {
				delay = 250,
			},
		},
		config = function(_, opts)
			opts = opts or {}
			opts.clues = opts.clues or {}
			vim.list_extend(opts.clues, {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				require("mini.clue").gen_clues.builtin_completion(),
				require("mini.clue").gen_clues.g(),
				require("mini.clue").gen_clues.marks(),
				require("mini.clue").gen_clues.registers(),
				require("mini.clue").gen_clues.windows(),
				require("mini.clue").gen_clues.z(),
			})

			require("mini.clue").setup(opts)
		end,
	},

	-- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		event = { "User VeryLazyFile" },
		dependencies = {
			{
				"echasnovski/mini.clue",
				optional = true,
				opts = function(_, opts)
					opts = opts or {}
					opts.clues = opts.clues or {}
					vim.list_extend(opts.clues, {
						{ mode = "n", keys = "<leader>h", desc = "[H]unk" },
					})
				end,
			},
		},
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			preview_config = { border = "none" },
			on_attach = function(_)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { desc = desc })
				end

				map("n", "[h", gs.prev_hunk, "Prev hunk")
				map("n", "]h", gs.next_hunk, "Next hunk")
				map("n", "<leader>hs", gs.stage_hunk, "[s]tage)")
				map("n", "<leader>hr", gs.reset_hunk, "[r]eset")
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "[s]tage)")
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "[r]eset")
				map("n", "<leader>hS", gs.stage_buffer, "[S]tage Buffer")
				map("n", "<leader>hR", gs.reset_buffer, "[R]eset Buffer")
				map("n", "<leader>hu", gs.undo_stage_hunk, "[U]ndo Stage")
				map("n", "<leader>hp", gs.preview_hunk, "[P]review")
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, "[b]lame")
				map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle [B]lame")
				map("n", "<leader>hd", gs.diffthis, "[d]iff")
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end, "[D]iff ~")
				map("n", "<leader>ht", gs.toggle_deleted, "[T]oggle Deleted")

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
	},

	-- lazygit integration
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "LazyGit",
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "lazygit", silent = true },
		},
	},
}
