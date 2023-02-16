return {
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-lua/popup.nvim", lazy = true },
	{ "ThePrimeagen/git-worktree.nvim", lazy = true },
	{ "tpope/vim-vinegar" },
	{ "mbbill/undotree", event = "VeryLazy" },
	--[[ { "p00f/nvim-ts-rainbow", event = "VeryLazy" }, ]]
	{ "tpope/vim-sleuth", event = "VeryLazy" },
	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{ "weilbith/nvim-code-action-menu", lazy = true, cmd = "CodeActionMenu" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup()
		end,
	},
	{ "norcalli/nvim-colorizer.lua" },
}
