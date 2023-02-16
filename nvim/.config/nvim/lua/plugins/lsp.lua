local status_ok, lspconfig = pcall(require, "lspconfig")

if not status_ok then
	return
end

--[[ require("doublew.lsp.mason") ]]
require("doublew.lsp.handlers").setup()

local opts = {
	on_attach = require("doublew.lsp.handlers").on_attach,
	capabilities = require("doublew.lsp.handlers").capabilities,
}

local function config(_config)
	return vim.tbl_deep_extend("force", _config or {}, opts)
end

lspconfig.jsonls.setup(config(require("doublew.lsp.settings.jsonls")))

lspconfig.sumneko_lua.setup(config(require("doublew.lsp.settings.sumneko_lua")))

--[[ lspconfig.pyright.setup(config(require("doublew.lsp.settings.pyright"))) ]]

lspconfig.pylsp.setup(config())

lspconfig.tsserver.setup(config(require("doublew.lsp.settings.tsserver")))

lspconfig.clangd.setup(config(require("doublew.lsp.settings.clangd")))

lspconfig.ansiblels.setup(config())

--[[ lspconfig.bashls.setup(config()) ]]

lspconfig.cmake.setup(config())

lspconfig.cssls.setup(config())

lspconfig.cssmodules_ls.setup(config())

--[[ lspconfig.eslint.setup(config()) ]]

lspconfig.dockerls.setup(config())

--[[ lspconfig.tailwindcss.setup(config(require("doublew.lsp.settings.tailwindcss"))) ]]

lspconfig.gopls.setup(config(require("doublew.lsp.settings.gopls")))

lspconfig.golangci_lint_ls.setup(config())

lspconfig.ruby_ls.setup(config())

lspconfig.rust_analyzer.setup(config(require("doublew.lsp.settings.rust_analyzer")))

lspconfig.asm_lsp.setup(config())

--[[ lspconfig.arduino_language_server.setup(config(require("doublew.lsp.settings.arduino"))) ]]

lspconfig.solidity_ls.setup(config())
