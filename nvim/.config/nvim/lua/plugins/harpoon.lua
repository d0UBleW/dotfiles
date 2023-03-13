return {
	{
		"ThePrimeagen/harpoon",
		keys = function()
			local mark_status_ok, mark = pcall(require, "harpoon.mark")
			if not mark_status_ok then
				return {}
			end
			local ui_status_ok, ui = pcall(require, "harpoon.ui")
			if not ui_status_ok then
				return {}
			end
			local lazy_keymap = require("doublew.keymap").lazy_keymap
			return {
				lazy_keymap("<leader>ma", mark.add_file, {
					desc = "[M]ark [A]dd file",
					mode = "n",
				}),
				lazy_keymap("<leader>e", ui.toggle_quick_menu, {
					desc = "Toggle harpoon quick menu",
					mode = "n",
				}),
				lazy_keymap("<leader>1", function()
					ui.nav_file(1)
				end, {
					desc = "Navigate to mark 1",
					mode = "n",
				}),
				lazy_keymap("<leader>2", function()
					ui.nav_file(2)
				end, {
					desc = "Navigate to mark 2",
					mode = "n",
				}),
				lazy_keymap("<leader>3", function()
					ui.nav_file(3)
				end, {
					desc = "Navigate to mark 3",
					mode = "n",
				}),
				lazy_keymap("<leader>4", function()
					ui.nav_file(4)
				end, {
					desc = "Navigate to mark 4",
					mode = "n",
				}),
			}
		end,
	},
}
