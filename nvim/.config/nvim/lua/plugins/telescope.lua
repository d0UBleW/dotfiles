return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-project.nvim" },
			{ "nvim-telescope/telescope-media-files.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = vim.fn.executable("make") == 1,
			},
			{
				"ThePrimeagen/refactoring.nvim",
				lazy = true,
				dependencies = {
					{ "nvim-lua/plenary.nvim" },
					{ "nvim-treesitter/nvim-treesitter" },
				},
			},
		},
		opts = function()
			local actions = require("telescope.actions")
			local trouble = require("trouble.providers.telescope")
			return {
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					path_display = { "smart" },
					borderchars = {
						prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					},

					mappings = {
						i = {
							["<C-s>"] = actions.cycle_history_next,
							["<C-r>"] = actions.cycle_history_prev,

							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,

							["<C-c>"] = actions.close,

							["<Down>"] = actions.move_selection_next,
							["<Up>"] = actions.move_selection_previous,

							["<CR>"] = actions.select_default,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,

							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,

							["<PageUp>"] = actions.results_scrolling_up,
							["<PageDown>"] = actions.results_scrolling_down,

							["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
							["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
							["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-l>"] = actions.complete_tag,
							["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
							["<M-t>"] = trouble.open_with_trouble,
						},

						n = {
							["<esc>"] = actions.close,
							["<CR>"] = actions.select_default,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,

							["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
							["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
							["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["H"] = actions.move_to_top,
							["M"] = actions.move_to_middle,
							["L"] = actions.move_to_bottom,

							["<Down>"] = actions.move_selection_next,
							["<Up>"] = actions.move_selection_previous,
							["gg"] = actions.move_to_top,
							["G"] = actions.move_to_bottom,

							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,

							["<PageUp>"] = actions.results_scrolling_up,
							["<PageDown>"] = actions.results_scrolling_down,

							["?"] = actions.which_key,
							["<M-t>"] = trouble.open_with_trouble,
						},
					},
				},
				pickers = {
					live_grep = {
						previewer = false,
						additional_args = function(opts)
							return { "--hidden" }
						end,
					},
					-- Default configuration for builtin pickers goes here:
					-- picker_name = {
					--   picker_config_key = value,
					--   ...
					-- }
					-- Now the picker_config_key will be applied every time you call this
					-- builtin picker
				},
				extensions = {
					media_files = {
						-- filetypes whitelist
						-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
						filetypes = { "png", "webp", "jpg", "jpeg" },
						find_cmd = "rg", -- find command (defaults to `fd`)
					},
					projects = {},
					live_grep_args = {
						--[[ auto_quoting = false, ]]
						--[[ mappings = { ]]
						--[[ 	i = { ]]
						--[[ 		["<C-w>"] = lga_actions.quote_prompt({ postfix = " -t" }), ]]
						--[[ 	}, ]]
						--[[ }, ]]
					},
					-- Your extension configuration goes here:
					-- extension_name = {
					--   extension_config_key = value,
					-- }
					-- please take a look at the readme of the extension you want to configure
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.load_extension("media_files")
			telescope.load_extension("projects")
			telescope.load_extension("project")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("fzf")
			telescope.load_extension("refactoring")
			local status_ok, _ = pcall(require, "noice")
			if status_ok then
				telescope.load_extension("noice")
			end
			telescope.setup(opts)
		end,
		keys = function()
			local no_preview = function()
				return require("telescope.themes").get_dropdown({
					borderchars = {
						{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
						results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
						preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					},
					winblend = 10,
					width = 0.8,
					previewer = false,
					--[[ prompt_title = false, ]]
				})
			end
			local status_ok, builtin = pcall(require, "telescope.builtin")
			if not status_ok then
				return
			end
			local lazy_keymap = require("doublew.keymap").lazy_keymap
			return {
				lazy_keymap("<leader>?", builtin.oldfiles, {
					desc = "[?] Find recently opened files",
				}),
				lazy_keymap("<leader><space>", builtin.buffers, {
					desc = "[ ] Find existing buffers",
				}),
				lazy_keymap("<leader>/", function()
					builtin.current_buffer_fuzzy_find(no_preview())
				end, {
					desc = "[/] Fuzzily search in current buffer",
				}),

				lazy_keymap("<leader>sf", builtin.find_files, {
					desc = "[S]earch [F]iles",
				}),

				lazy_keymap("<leader>sh", function()
					builtin.help_tags(no_preview())
				end, {
					desc = "[S]earch [H]elp",
				}),

				lazy_keymap("<leader>sw", builtin.grep_string, {
					desc = "[S]earch current [W]ord",
				}),

				lazy_keymap("<leader>sd", function()
					builtin.diagnostics(no_preview())
				end, {
					desc = "[S]earch [D]iagnostics",
				}),

				lazy_keymap("<leader>sg", builtin.git_files),
				lazy_keymap("<leader>ts", "<cmd>Telescope live_grep<CR>"),
				lazy_keymap("<leader>tp", "<cmd>Telescope projects<CR>"),
				lazy_keymap("<leader>T", "<cmd>Telescope<CR>"),
				lazy_keymap("<leader>sds", builtin.lsp_document_symbols, {
					desc = "[S]earch [D]ocument [S]ymbols",
				}),
				lazy_keymap("<leader>sws", builtin.lsp_workspace_symbols, {
					desc = "[S]earch [W]orkspace [S]ymbols",
				}),
				lazy_keymap("<leader>rr", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", {
					mode = "v",
					desc = "Refactoring",
				}),
			}
		end,
	},
}
