return {
	{
		"abecodes/tabout.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
		},
		event = "VeryLazy",
		config = function()
			require("tabout").setup()
		end,
	},
}
