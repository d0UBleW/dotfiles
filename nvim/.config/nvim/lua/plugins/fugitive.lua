return {
	{
		"tpope/vim-fugitive",
		keys = function()
			local lazy_keymap = require("doublew.keymap").lazy_keymap
			return {
				lazy_keymap("<leader>gs", vim.cmd.Git, {
					mode = "n",
					desc = "[G]it [S]tatus",
				}),
			}
		end,
	},
}
