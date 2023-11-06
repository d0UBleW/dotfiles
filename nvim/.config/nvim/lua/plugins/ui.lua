return {
	-- Better `vim.notify()`
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
			{
				"<C-l>",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			local Util = require("util.lazyvim")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},

	-- better vim.ui
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	-- This is what powers LazyVim's fancy-looking
	-- tabs, which include filetype icons and close buttons.
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
	-- 		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
	-- 	},
	-- 	opts = {
	-- 		options = {
	--        -- stylua: ignore
	--        close_command = function(n) require("mini.bufremove").delete(n, false) end,
	--        -- stylua: ignore
	--        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
	-- 			diagnostics = "nvim_lsp",
	-- 			always_show_bufferline = false,
	-- 			diagnostics_indicator = function(_, _, diag)
	-- 				local icons = require("config.icons").diagnostics
	-- 				local ret = (diag.error and icons.Error .. diag.error .. " " or "")
	-- 					.. (diag.warning and icons.Warn .. diag.warning or "")
	-- 				return vim.trim(ret)
	-- 			end,
	-- 			offsets = {
	-- 				{
	-- 					filetype = "neo-tree",
	-- 					text = "Neo-tree",
	-- 					highlight = "Directory",
	-- 					text_align = "left",
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local branch = {
				"branch",
				icons_enabled = true,
				icon = "",
			}
			return {
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "|" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { branch, "diagnostics" },
					lualine_c = {
						"filename",
						{
							function()
								return require("nvim-navic").get_location()
							end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			}
		end,
	},

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- char = "▏",
			char = "│",
			filetype_exclude = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},

	-- Active indent guide and indent text objects. When you're browsing
	-- code, this highlights the current level of indentation, and animates
	-- the highlighting.
	-- {
	--  "echasnovski/mini.indentscope",
	--  version = false, -- wait till new 0.7.0 release to put it back on semver
	--  event = { "BufReadPre", "BufNewFile" },
	--  opts = {
	--      -- symbol = "▏",
	--      symbol = "│",
	--      options = { try_as_border = true },
	--  },
	--  init = function()
	--      vim.api.nvim_create_autocmd("FileType", {
	--          pattern = {
	--              "help",
	--              "alpha",
	--              "dashboard",
	--              "neo-tree",
	--              "Trouble",
	--              "lazy",
	--              "mason",
	--              "notify",
	--              "toggleterm",
	--              "lazyterm",
	--          },
	--          callback = function()
	--              vim.b.miniindentscope_disable = true
	--          end,
	--      })
	--  end,
	-- },

	-- noicer ui
	{
		"folke/which-key.nvim",
		opts = function(_, opts)
			if require("util.lazyvim").has("noice.nvim") then
				opts.defaults["<leader>sn"] = { name = "+noice" }
			end
		end,
	},

	-- 	{
	-- 		"folke/noice.nvim",
	-- 		event = "VeryLazy",
	-- 		opts = {
	-- 			-- cmdline = {
	-- 			-- 	view = "cmdline",
	-- 			-- },
	-- 			lsp = {
	-- 				override = {
	-- 					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 					["vim.lsp.util.stylize_markdown"] = true,
	-- 					["cmp.entry.get_documentation"] = true,
	-- 				},
	-- 				progress = {
	-- 					enabled = false,
	-- 				},
	-- 			},
	-- 			routes = {
	-- 				{
	-- 					filter = {
	-- 						event = "msg_show",
	-- 						any = {
	-- 							{ find = "%d+L, %d+B" },
	-- 							{ find = "; after #%d+" },
	-- 							{ find = "; before #%d+" },
	-- 						},
	-- 					},
	-- 					view = "mini",
	-- 				},
	-- 			},
	-- 			presets = {
	-- 				bottom_search = true,
	-- 				command_palette = true,
	-- 				long_message_to_split = true,
	-- 				inc_rename = true,
	-- 			},
	-- 			-- signature = {
	-- 			-- 	auto_open = {
	-- 			-- 		trigger = false,
	-- 			-- 	},
	-- 			-- },
	-- 		},
	-- -- stylua: ignore
	-- keys = {
	-- { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
	-- { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
	-- { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
	-- { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
	-- { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
	-- { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
	-- { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
	-- },
	-- 	},

	-- lsp symbol navigation for lualine. This shows where
	-- in the code structure you are - within functions, classes,
	-- etc - in the statusline.
	{
		"SmiteshP/nvim-navic",
		lazy = true,
		init = function()
			vim.g.navic_silence = true
			require("util.lazyvim").on_attach(function(client, buffer)
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, buffer)
				end
			end)
		end,
		opts = function()
			return {
				separator = " ",
				highlight = true,
				depth_limit = 5,
				icons = require("config.icons").kinds,
			}
		end,
	},

	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },
}
