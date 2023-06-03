return {
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
		keys = function()
			local lazy_keymap = require("doublew.keymap").lazy_keymap
			return {
				lazy_keymap("<A-w>", function()
					require("spider").motion("w")
				end),
				lazy_keymap("<A-e>", function()
					require("spider").motion("e")
				end),
				lazy_keymap("<A-b>", function()
					require("spider").motion("b")
				end),
			}
		end,
	},
}
