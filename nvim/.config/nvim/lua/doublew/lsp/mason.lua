local mason_status, mason = pcall(require, "mason")

if not mason_status then
	return
end

local mason_lsp_status, lspconfig = pcall(require, "mason-lspconfig")

if not mason_lsp_status then
	return
end

mason.setup({})

lspconfig.setup({
	ensure_installed = { "sumneko_lua" },
})
