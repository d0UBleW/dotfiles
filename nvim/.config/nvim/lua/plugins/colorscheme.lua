return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = function(plugin)
			local time = os.date("*t").hour
			vim.opt.background = "light"
			if time > 18 then
				vim.opt.backgrond = "dark"
			end
			return {
				style = "storm",
				light_style = "day",
				transparent = false,
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
	},
}
