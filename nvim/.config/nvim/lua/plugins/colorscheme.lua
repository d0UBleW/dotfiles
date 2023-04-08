return {
	{
		"folke/tokyonight.nvim",
		opts = function(plugin)
			local time = os.date("*t").hour
			vim.opt.background = "light"
			if time > 17 or time < 6 then
				vim.opt.background = "dark"
			end
			return {
				style = "storm",
				light_style = "day",
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					functions = {},
					variables = {},
					sidebars = "dark",
					floats = "dark",
				},
				sidebars = { "qf", "help" },
				day_brightness = 0.3,
				hide_inactive_statusline = false,
				dim_inactive = false,
				lualine_bold = false,
			}
		end,
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd([[ colorscheme tokyonight ]])
		end,
	},
}
