return {
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		keys = function()
			local lazy_keymap = require("doublew.keymap").lazy_keymap
			return {
				lazy_keymap("<leader>gs", vim.cmd.Git, {
					mode = "n",
					desc = "[G]it [S]tatus",
				}),
				lazy_keymap("<leader>gh", "<cmd>diffget //2<CR>", {
					mode = "n",
					desc = "Get left",
				}),
				lazy_keymap("<leader>gl", "<cmd>diffget //3<CR>", {
					mode = "n",
					desc = "Get right",
				}),
			}
		end,
	},
}
