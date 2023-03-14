return {
	{
		"TimUntersberger/neogit",
		keys = function()
			local lazy_keymap = require("doublew.keymap").lazy_keymap
			local status_ok, neogit = pcall(require, "neogit")
			if not status_ok then
				return
			end
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
