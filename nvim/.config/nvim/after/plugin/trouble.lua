local status_ok, trouble = pcall(require, "trouble")

if not status_ok then
	return
end

trouble.setup()

local nnoremap = require("doublew.keymap").nnoremap

nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>")
nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>")
nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>")
nnoremap("<leader>gd", "<cmd>TroubleToggle lsp_definitions<cr>")
