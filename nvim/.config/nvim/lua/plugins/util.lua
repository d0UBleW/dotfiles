return {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },
	{ "ThePrimeagen/git-worktree.nvim" },
	{ "tpope/vim-vinegar" },
	{ "mbbill/undotree" },
	{ "p00f/nvim-ts-rainbow" },
	{ "tpope/vim-sleuth" },
	{ "tpope/vim-unimpaired" },
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	{ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup()
		end,
	},
}
