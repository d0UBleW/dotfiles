local buf_nnoremap = require("doublew.keymap").buf_nnoremap
local buf_inoremap = require("doublew.keymap").buf_inoremap

local function metals_keymaps(bufnr)
	buf_nnoremap(bufnr, "gD", "<cmd>lua vim.lsp.buf.definition()<CR>")
	buf_nnoremap(bufnr, "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	buf_nnoremap(bufnr, "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	buf_nnoremap(bufnr, "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
	buf_nnoremap(bufnr, "gds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
	buf_nnoremap(bufnr, "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
	buf_inoremap(bufnr, "<C-S-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	buf_nnoremap(bufnr, "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>")
	buf_nnoremap(bufnr, "<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	buf_nnoremap(bufnr, "<leader>ws", "<cmd>lua require('metals').hover_worksheet()<CR>")

	buf_nnoremap(bufnr, "<leader>dc", "<cmd>lua require('dap').continue()<CR>")
	buf_nnoremap(bufnr, "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>")
	buf_nnoremap(bufnr, "<leader>dK", "<cmd>lua require('dap.ui.widgets').hover()<CR>")
	buf_nnoremap(bufnr, "<leader>dt", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
	buf_nnoremap(bufnr, "<leader>dso", "<cmd>lua require('dap').step_over()<CR>")
	buf_nnoremap(bufnr, "<leader>dsi", "<cmd>lua require('dap').step_into()<CR>")
	buf_nnoremap(bufnr, "<leader>dl", "<cmd>lua require('dap').run_last()<CR>")
end

local function metals_highlight_document(client, bufnr)
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

local status_ok, metals = pcall(require, "metals")

if not status_ok then
	return
end

local metals_config = metals.bare_config()

metals_config.settings = {
	showImplicitArguments = true,
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
metals_config.init_options.statusBarProvider = "on"

-- Debug settings if you're using nvim-dap
local dap_status_ok, dap = pcall(require, "dap")

if dap_status_ok then
	dap.configurations.scala = {
		{
			type = "scala",
			request = "launch",
			name = "RunOrTest",
			metals = {
				runType = "runOrTestFile",
				--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
			},
		},
		{
			type = "scala",
			request = "launch",
			name = "Test Target",
			metals = {
				runType = "testTarget",
			},
		},
	}
end

metals_config.on_attach = function(client, bufnr)
	if dap_status_ok then
		require("metals").setup_dap()
	end
	metals_keymaps(bufnr)
	metals_highlight_document(client, bufnr)
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	-- NOTE: You may or may not want java included here. You will need it if you
	-- want basic Java support but it may also conflict if you are using
	-- something like nvim-jdtls which also works on a java filetype autocmd.
	pattern = { "scala", "sbt", "java" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})
