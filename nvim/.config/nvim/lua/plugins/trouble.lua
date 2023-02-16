return {
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		keys = function()
			local lazy_keymap = require("doublew.keymap").lazy_keymap
			return {
				lazy_keymap("<leader>xx", "<cmd>TroubleToggle<cr>", {
					mode = "n",
					desc = "Trouble",
				}),
				lazy_keymap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {
					mode = "n",
					desc = "Trouble workspace diagnostics",
				}),
				lazy_keymap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {
					mode = "n",
					desc = "Trouble document diagnostics",
				}),
				lazy_keymap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {
					mode = "n",
					desc = "Trouble quickfix",
				}),
				lazy_keymap("<leader>xl", "<cmd>TroubleToggle loclist<cr>", {
					mode = "n",
					desc = "Trouble loclist",
				}),
				lazy_keymap("gR", "<cmd>TroubleToggle lsp_references<cr>", {
					mode = "n",
					desc = "Trouble LSP references",
				}),
				lazy_keymap("<leader>gd", "<cmd>TroubleToggle lsp_definitions<cr>", {
					mode = "n",
					desc = "Trouble LSP definitions",
				}),
			}
		end,
	},
}
