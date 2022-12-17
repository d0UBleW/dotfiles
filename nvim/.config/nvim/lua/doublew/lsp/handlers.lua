local M = {}

local buf_nnoremap = require("doublew.keymap").buf_nnoremap
local buf_inoremap = require("doublew.keymap").buf_inoremap

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end
	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Document Highlighting",
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Clear all highlighted references",
		})
	end
end

local function lsp_keymaps(bufnr)
	buf_nnoremap(bufnr, "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration " })
	buf_nnoremap(bufnr, "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
	buf_nnoremap(bufnr, "K", vim.lsp.buf.hover, { desc = "[K] Hover " })
	buf_nnoremap(bufnr, "gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
	buf_inoremap(bufnr, "<C-S-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
	buf_nnoremap(bufnr, "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
	buf_nnoremap(bufnr, "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
	buf_nnoremap(bufnr, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
	buf_nnoremap(bufnr, "[d", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>")
	buf_nnoremap(bufnr, "gl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>")
	buf_nnoremap(bufnr, "]d", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>")
	buf_nnoremap(bufnr, "<leader>q", vim.diagnostic.setloclist)
	buf_nnoremap(bufnr, "gds", vim.lsp.buf.document_symbol)
	buf_nnoremap(bufnr, "gws", vim.lsp.buf.workspace_symbol)
	--[[ buf_nnoremap(bufnr, "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>") ]]
	--[[ buf_nnoremap(bufnr, "<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>") ]]
	--[[ buf_nnoremap(bufnr, "<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>") ]]
	-- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		if vim.lsp.buf.format then
			vim.lsp.buf.format({ async = true })
		elseif vim.lsp.buf.formatting then
			vim.lsp.buf.formatting()
		end
	end, { desc = "Format current buffer with LSP" })
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end
	lsp_keymaps(bufnr)
	lsp_highlight_document(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
