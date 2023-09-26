return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		cmd = "Mason",
		dependencies = {
			"williamboman/nvim-lsp-installer",
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = { "lua_ls" },
				},
				config = function()
					require("mason-lspconfig").setup()
				end,
			},
		},
		config = function()
			require("mason").setup()
		end,
	},
}
