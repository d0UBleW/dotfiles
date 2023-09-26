return {
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
		keys = function()
			local lazy_keymap = require("util.keymaps").lazy_keymap
			return {
				lazy_keymap("<A-w>", "<cmd>lua require('spider').motion('w')<CR>", {
					desc = "Spider-w",
					mode = { "n", "o", "x" },
				}),
				lazy_keymap("<A-e>", "<cmd>lua require('spider').motion('e')<CR>", {
					desc = "Spider-e",
					mode = { "n", "o", "x" },
				}),
				lazy_keymap("<A-b>", "<cmd>lua require('spider').motion('b')<CR>", {
					desc = "Spider-b",
					mode = { "n", "o", "x" },
				}),
			}
		end,
	},
}

