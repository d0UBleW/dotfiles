return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"j-hui/fidget.nvim",
			"williamboman/mason.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			require("plugins.lsp.handlers").setup()
			local opts = {
				on_attach = require("plugins.lsp.handlers").on_attach,
				capabilities = require("plugins.lsp.handlers").capabilities,
			}
			local function config(_config)
				return vim.tbl_deep_extend("force", _config or {}, opts)
			end

			lspconfig.jsonls.setup(config(require("plugins.lsp.settings.jsonls")))

			lspconfig.lua_ls.setup(config(require("plugins.lsp.settings.lua_ls")))

			--[[ lspconfig.pyright.setup(config(require("plugins.lsp.settings.pyright"))) ]]

			lspconfig.pylsp.setup(config(require("plugins.lsp.settings.pylsp")))

			lspconfig.tsserver.setup(config(require("plugins.lsp.settings.tsserver")))

			lspconfig.clangd.setup(config(require("plugins.lsp.settings.clangd")))

			--[[ lspconfig.ansiblels.setup(config()) ]]

			--[[ lspconfig.bashls.setup(config()) ]]

			lspconfig.cmake.setup(config())

			lspconfig.cssls.setup(config())

			lspconfig.cssmodules_ls.setup(config())

			--[[ lspconfig.eslint.setup(config()) ]]

			lspconfig.dockerls.setup(config())

			--[[ lspconfig.tailwindcss.setup(config(require("plugins.lsp.settings.tailwindcss"))) ]]

			lspconfig.gopls.setup(config(require("plugins.lsp.settings.gopls")))

			lspconfig.golangci_lint_ls.setup(config())

			lspconfig.ruby_ls.setup(config())

			lspconfig.rust_analyzer.setup(config(require("plugins.lsp.settings.rust_analyzer")))

			lspconfig.asm_lsp.setup(config())

			--[[ lspconfig.arduino_language_server.setup(config(require("plugins.lsp.settings.arduino"))) ]]

			lspconfig.solidity_ls.setup(config())
		end,
	},
}
