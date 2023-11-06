return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = function(_)
			return {
				variant = "auto",
				dark_variant = "moon",
				disable_italics = true,
			}
		end,
	},
	{
		"folke/tokyonight.nvim",
		opts = function(_)
			return {
				style = "storm",
				light_style = "day",
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = false },
					keywords = { italic = true },
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
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = function(_)
			return {
				-- flavour = "frappe", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "frappe",
				},
				transparent_background = true,
				show_end_of_buffer = false, -- show the '~' characters after the end of buffers
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					notify = false,
					mini = false,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			}
		end,
		config = function(_, opts)
			require("catppuccin").setup(opts)
		end,
	},
}
