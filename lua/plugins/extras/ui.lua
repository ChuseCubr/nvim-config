return {
	-- Fancy notifs
	{
		"echasnovski/mini.notify",
		event = "VeryLazy",
		version = false,
		config = function()
			local notify = require("mini.notify")
			notify.setup()
			vim.notify = notify.make_notify()
		end,
	},

	-- Animations (for accessibility)
	{
		"echasnovski/mini.animate",
	  optional = true,
		event = "VeryLazy",
		version = false,
		opts = function()
			local timing_func = require("mini.animate").gen_timing.quadratic({
				duration = 100,
				unit = "total",
			})
			return {
				cursor = { timing = timing_func },
				scroll = { timing = timing_func },
				resize = { timing = timing_func },
				open = { timing = timing_func },
				close = { timing = timing_func },
			}
		end,
	},
}
