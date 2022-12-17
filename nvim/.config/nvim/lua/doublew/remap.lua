local status_ok_km, keymap = pcall(require, "doublew.keymap")

if not status_ok_km then
	return
end

local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap
local cmap = keymap.cmap

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

cmap("<C-a>", "<home>")
cmap("<C-e>", "<end>")

nnoremap("-", "<cmd>Ex<CR>")

nnoremap("<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle [U]ndotree" })
nnoremap("<leader>w", "<cmd>set wrap!<CR>", { desc = "Toggle [W]rap" })

nnoremap("<leader>h", "<cmd>wincmd h<CR>")
nnoremap("<leader>j", "<cmd>wincmd j<CR>")
nnoremap("<leader>k", "<cmd>wincmd k<CR>")
nnoremap("<leader>l", "<cmd>wincmd l<CR>")

-- nnoremap("<leader><tab>", "<cmd>tabnext<CR>")
-- nnoremap("<S-tab>", "<cmd>tabprevious<CR>")
nnoremap("<S-l>", "<cmd>tabnext<CR>")
nnoremap("<S-h>", "<cmd>tabprevious<CR>")
nnoremap("te", "<cmd>tabedit<CR>")

nnoremap("co", "<cmd>copen<CR>")
nnoremap("cc", "<cmd>cclose<CR>")

--[[ nnoremap("<F5>", "<cmd>lua require('doublew.toggle').toggle_bg()<CR>") ]]

nnoremap("<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
nnoremap("<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
nnoremap("<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
nnoremap("<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
nnoremap("<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
nnoremap("<leader>sw", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
nnoremap("<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
nnoremap("<leader>tg", "<cmd>Telescope git_files<CR>")
nnoremap("<leader>ts", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>tp", "<cmd>Telescope projects<CR>")
nnoremap("<leader>T", "<cmd>Telescope<CR>")
nnoremap("<leader>sds", require("telescope.builtin").lsp_document_symbols, { desc = "[S]earch [D]ocument [S]ymbols" })
nnoremap("<leader>sws", require("telescope.builtin").lsp_workspace_symbols, { desc = "[S]earch [W]orkspace [S]ymbols" })

nnoremap("<leader>fm", "<cmd>Format<CR>")

vnoremap("<", "<gv")
vnoremap(">", ">gv")

vnoremap("<leader>p", '"_dP')

nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>")
nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>")
nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>")
nnoremap("<leader>gd", "<cmd>TroubleToggle lsp_definitions<cr>")

vim.api.nvim_create_user_command("IDE", function(_)
	require("doublew.ide")
end, { desc = "Enable IDE" })
