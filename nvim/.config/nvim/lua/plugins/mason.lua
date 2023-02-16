return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		dependencies = {
			"williamboman/nvim-lsp-installer",
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = { "lua_ls", "rust_analyzer" },
				},
			},
		},
		config = function()
			require("mason").setup()
		end,
	},
}
