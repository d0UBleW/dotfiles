local status_ok, lspconfig = pcall(require, "lspconfig")

if not status_ok then
	return
end

require("doublew.lsp.mason")
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
lspconfig.pyright.setup(config(require("doublew.lsp.settings.pyright")))
lspconfig.tsserver.setup(config(require("doublew.lsp.settings.tsserver")))
