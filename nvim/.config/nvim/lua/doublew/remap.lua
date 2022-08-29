local status_ok_km, keymap = pcall(require, "doublew.keymap")

if not status_ok_km then
	return
end

local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap
local cmap = keymap.cmap

cmap("<C-a>", "<home>")
cmap("<C-e>", "<end>")

nnoremap("-", "<cmd>Ex<CR>")

nnoremap("<leader>u", "<cmd>UndotreeToggle<CR>")

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

nnoremap("<leader>tf", "<cmd>Telescope find_files hidden=true<CR>")
nnoremap("<leader>tg", "<cmd>Telescope git_files<CR>")
nnoremap("<leader>ts", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>T", "<cmd>Telescope<CR>")

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
