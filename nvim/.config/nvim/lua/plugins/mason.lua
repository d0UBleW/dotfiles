return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/nvim-lsp-installer",
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = { "sumneko_lua", "rust_analyzer" },
				},
			},
		},
	},
}
