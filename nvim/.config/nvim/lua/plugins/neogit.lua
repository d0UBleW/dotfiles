return {
	{
		"TimUntersberger/neogit",
		keys = function()
			local lazy_keymap = require("doublew.keymap").lazy_keymap
			local neogit = require("neogit")
			return {
				lazy_keymap("<leader>gs", function()
					neogit.open()
				end, {
					mode = "n",
					desc = "[G]it [s]tatus",
				}),
				lazy_keymap("<leader>ga", "<cmd>!git fetch --all <CR>", {
					mode = "n",
					desc = "[G]it fetch [a]ll",
				}),
			}
		end,
	},
}
